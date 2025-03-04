// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Shop} from "../src/21_Shop.sol";

contract TestShop is Test {
    address public player = address(0xbad);
    Shop public instance;
    uint256 initialPrice;

    function setUp() public {
        vm.deal(player, 0.001 ether);
        instance = new Shop();
        initialPrice = instance.price();
    }

    function testSolution() public {
        vm.startPrank(player);

        // Your exploit goes here

        assertLt(instance.price(), initialPrice);
        vm.stopPrank();
    }
}
