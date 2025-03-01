// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {NaughtCoin} from "../src/15_NaughtCoin.sol";

contract TestNaughtCoin is Test {
    address public player = address(0xbad);
    NaughtCoin public instance;

    function setUp() public {
        vm.deal(player, 0.001 ether);
        instance = new NaughtCoin(player);
    }

    function testSolution() public {
        vm.startPrank(player);

        // Your exploit goes here

        vm.stopPrank();
        assertEq(instance.balanceOf(player), 0);
    }
}
