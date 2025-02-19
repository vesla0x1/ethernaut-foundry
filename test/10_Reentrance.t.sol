// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import {Test, console} from "forge-std/Test.sol";
import {Reentrance} from "../src/10_Reentrance.sol";

contract TestReentrance is Test {
    address public player = address(0xbad);
    uint256 constant initialContractBalance = 0.1 ether;
    uint256 constant initialPlayerBalance = 0.001 ether;
    Reentrance public instance;

    function setUp() public {
        vm.deal(player, initialPlayerBalance);
        instance = new Reentrance();
        address(instance).transfer(initialContractBalance);
    }

    function testSolution() public {
        vm.startPrank(player);

        // Your exploit goes here

        vm.stopPrank();

        assertEq(address(instance).balance, 0);
        assertEq(player.balance, initialContractBalance + initialPlayerBalance);
    }
}
