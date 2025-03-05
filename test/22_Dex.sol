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

        // Your exploit goes here

        assertTrue((
            t1.balanceOf(address(instance)) == 0 ||
            t2.balanceOf(address(instance)) == 0
        ));

        vm.stopPrank();
    }
}
