// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Recovery, SimpleToken} from "../src/17_Recovery.sol";
import {LOST_TOKEN_ADDR} from "../src/utils/Utils.sol";

contract TestRecovery is Test {
    address public player = address(0xbad);
    Recovery public instance;

    function setUp() public {
        vm.deal(player, 0.001 ether);
        instance = new Recovery();
        instance.generateToken("ETH", 10 * 10e18);
        payable(address(LOST_TOKEN_ADDR)).send(0.001 ether); // you are not suppose to know this!
    }

    function testSolution() public {
        vm.startPrank(player);

        // Your exploit goes here

        vm.stopPrank();

        assertEq(address(LOST_TOKEN_ADDR).balance, 0);
    }
}
