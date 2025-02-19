// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Telephone} from "../src/04_Telephone.sol";

contract TestTelephone is Test {
    address public player = address(0xbad);
    Telephone public instance;

    function setUp() public {
        instance = new Telephone();
        vm.deal(player, 0.001 ether);
    }

    function testSolution() public {
        vm.startPrank(player);

        assertEq(instance.owner(), player);

        vm.stopPrank();
    }
}
