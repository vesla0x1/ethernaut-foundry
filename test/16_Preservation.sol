// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Preservation, LibraryContract} from "../src/16_Preservation.sol";

contract TestPreservation is Test {
    address public player = address(0xbad);
    LibraryContract public lib1;
    LibraryContract public lib2;
    Preservation public instance;

    function setUp() public {
        vm.deal(player, 0.001 ether);
        lib1 = new LibraryContract();
        lib2 = new LibraryContract();
        instance = new Preservation(address(lib1), address(lib2));
    }

    function testSolution() public {
        vm.startPrank(player);

        // Your exploit goes here

        vm.stopPrank();
        assertEq(instance.owner(), player);
    }
}
