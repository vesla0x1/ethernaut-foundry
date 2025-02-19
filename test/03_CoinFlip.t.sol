// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {CoinFlip} from "../src/03_CoinFlip.sol";

contract TestCoinFlip is Test {
    address public player = address(0xbad);
    CoinFlip public instance;

    function setUp() public {
        instance = new CoinFlip();
        vm.deal(player, 0.001 ether);
    }

    function testSolution() public {
        vm.startPrank(player);

        assertGe(instance.consecutiveWins(), 10);

        vm.stopPrank();
    }
}
