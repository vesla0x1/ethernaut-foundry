// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Delegation, Delegate} from "../src/06_Delegation.sol";

contract TestDelegation is Test {
    address public player = address(0xbad);
    Delegate public delegateInstance;
    Delegation public instance;

    function setUp() public {
        delegateInstance = new Delegate(msg.sender);
        instance = new Delegation(address(delegateInstance));
        vm.deal(player, 0.001 ether);
    }

    function testSolution() public {
        vm.startPrank(player);

        assertEq(instance.owner(), player);

        vm.stopPrank();
    }
}
