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

        // PUSH1 42: 60 2a
        // PUSH1 0: 60 00
        // MSTORE: 52
        // PUSH1 32: 60 20 
        // PUSH1 0: 60 00
        // RETURN: F3 offset, size 

        // runtime bytecode: 602a60005260206000f3

        // PUSH1 10: 60 0a
        // PUSH1 XX: 60 XX -> 0c (this initialization bytecode has 12 bytes)
        // PUSH1 00: 60 00
        // CODECOPY: 39 <destOffset> <offset> <size>
        // PUSH1 10: 60 0a
        // PUSH1 0:  60 00
        // RETRUN: f3 offset, size

        // initialization bytecode: 600a600c600039600a6000f3

        // final bytecode: 600a600c600039600a6000f3602a60005260206000f3
        assembly {
            let ptr := mload(0x00)
            mstore(ptr, shl(0x50, 0x600a600c600039600a6000f3602a60005260206000f3))
            solver := create(0, ptr, 0x16)
        }

        instance.setSolver(solver);

        vm.stopPrank();

        assertEq(IMagicNum(solver).whatIsTheMeaningOfLife(), 42);

        uint256 codeSize;
        assembly {
            codeSize := extcodesize(solver)
        }
        assertLe(codeSize, 10); 
    }
}
