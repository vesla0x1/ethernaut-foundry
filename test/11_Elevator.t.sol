// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Elevator, Building} from "../src/11_Elevator.sol";

contract TestElevator is Test {
    address public player = address(0xbad);
    Elevator public instance;

    function setUp() public {
        vm.deal(player, 0.001 ether);
        instance = new Elevator();
    }

    function testSolution() public {
        vm.startPrank(player);

        // Your exploit goes here

        vm.stopPrank();
        assertTrue(instance.top());
    }
}
