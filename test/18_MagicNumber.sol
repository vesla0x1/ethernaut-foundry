// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {MagicNum} from "../src/18_MagicNumber.sol";

interface IMagicNum {
    function whatIsTheMeaningOfLife() external returns (uint256);
}

contract TestMagicNum is Test {
    address public player = address(0xbad);
    MagicNum public instance;

    function setUp() public {
        vm.deal(player, 0.001 ether);
        instance = new MagicNum();
    }

    function testSolution() public {
        address solver;
        vm.startPrank(player);

        // Your exploit goes here

        vm.stopPrank();

        assertEq(IMagicNum(solver).whatIsTheMeaningOfLife(), 42);

        uint256 codeSize;
        assembly {
            codeSize := extcodesize(solver)
        }
        assertLe(codeSize, 10); 
    }
}
