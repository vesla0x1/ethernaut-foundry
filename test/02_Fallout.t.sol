// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import {Test, console} from "forge-std/Test.sol";
import {Fallout} from "../src/02_Fallout.sol";

contract TestFallout is Test {
    address public player = address(0xbad);
    Fallout public instance;

    function setUp() public {
        instance = new Fallout();
        vm.deal(player, 0.001 ether);
    }

    function testSolution() public {
        vm.startPrank(player);

        instance.Fal1out();
        assertEq(instance.owner(), player);

        vm.stopPrank();
    }
}
