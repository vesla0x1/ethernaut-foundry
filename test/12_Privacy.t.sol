// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Privacy} from "../src/12_Privacy.sol";

contract TestPrivacy is Test {
    address public player = address(0xbad);
    Privacy public instance;

    function setUp() public {
        vm.deal(player, 0.001 ether);

        bytes32[3] memory data;
        for (uint8 i = 0; i < 3; i++) {
            data[i] = bytes32(vm.randomBytes(32));
        }

        instance = new Privacy(data);
    }

    function testSolution() public {
        vm.startPrank(player);

        bytes32 key = vm.load(address(instance), bytes32(uint256(5)));
        instance.unlock(bytes16(key));

        vm.stopPrank();
        assertFalse(instance.locked());
    }
}
