// SPDX-License-Identifier: UNLICENSED
pragma solidity <0.7.0;
pragma experimental ABIEncoderV2;

import {Test, console} from "forge-std/Test.sol";
import {Motorbike, Engine} from "../src/25_Motorbike.sol";

contract TestMotorbike is Test {
    address public player = address(0xbad);
    Motorbike public instance;

    function setUp() public {
        instance = new Motorbike(address(new Engine()));

        vm.startPrank(player);

        // Your exploit goes here

        vm.stopPrank();
    }

    function testSolution() public {
        address implementationAddr = address(
            uint160(uint256(vm.load(
                address(instance),
                hex"360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc"
            ))
        ));
        uint256 size;
        assembly { size := extcodesize(implementationAddr) }
        assertEq(size, 0);
    }
}
