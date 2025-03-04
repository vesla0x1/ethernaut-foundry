// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Denial} from "../src/20_Denial.sol";

contract TestDenial is Test {
    address public player = address(0xbad);
    uint256 constant initialBalance = 0.001 ether;
    Denial public instance;

    function setUp() public {
        vm.deal(player, 0.001 ether);
        instance = new Denial();
        payable(address(instance)).transfer(initialBalance);
    }

    function testSolution() public {
        vm.startPrank(player);

        // Your exploit goes here

        assertGe(address(instance).balance, 100);
        vm.expectRevert();
        instance.withdraw{gas: 1000000}();

        vm.stopPrank();
    }
}
