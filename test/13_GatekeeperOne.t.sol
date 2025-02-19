// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {GatekeeperOne} from "../src/13_GatekeeperOne.sol";

contract TestGatekeeperOne is Test {
    address public player = address(0xbad);
    GatekeeperOne public instance;

    function setUp() public {
        vm.deal(player, 0.001 ether);
        instance = new GatekeeperOne();
    }

    function testSolution() public {
        vm.startPrank(player);

        // Your exploit goes here

        vm.stopPrank();
        assertNotEq(instance.entrant(), address(0));
    }
}
