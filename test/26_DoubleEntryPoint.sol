// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {
    DoubleEntryPoint,
    DelegateERC20,
    CryptoVault,
    LegacyToken,
    Forta,
    IForta,
    IDetectionBot
} from "../src/26_DoubleEntryPoint.sol";

contract DetectionBot is IDetectionBot {
    address private cryptoVault;

    constructor(address _cryptoVault) {
        cryptoVault = _cryptoVault;
    }

    function handleTransaction(address user, bytes calldata msgData) public {
        address origSender;
        assembly {
            // we need to check if origSender == CryptoVault
            // origSender is at 0xa8 calldata position.
            origSender := calldataload(0xa8)
        }
        if (origSender == cryptoVault) {
            IForta(msg.sender).raiseAlert(user);
        }
    }
}

contract TestDoubleEntryPoint is Test {
    address public player = address(0xbad);
    DoubleEntryPoint public instance;
    CryptoVault public cryptoVault;
    LegacyToken public legacyToken;
    Forta public forta;
    DetectionBot public detectionBot;

    function setUp() public {
        legacyToken = new LegacyToken();
        cryptoVault = new CryptoVault(player);
        forta = new Forta();
        detectionBot = new DetectionBot(address(cryptoVault));
        instance = new DoubleEntryPoint(address(legacyToken), address(cryptoVault), address(forta), player);
        cryptoVault.setUnderlying(address(instance));
        legacyToken.delegateToNewContract(DelegateERC20(address(instance)));
        legacyToken.mint(address(cryptoVault), 100 ether);
    }

    function testSolution() public {
        vm.startPrank(player);
        forta.setDetectionBot(address(detectionBot));
        vm.expectRevert("Alert has been triggered, reverting");
        cryptoVault.sweepToken(legacyToken);
        vm.stopPrank();
    }
}
