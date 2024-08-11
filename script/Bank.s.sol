// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import "../src/Bank.sol";
import "../src/RockToken.sol";
contract DeployBank is Script {
    function run() external {
        vm.startBroadcast();
        address rocktoken = address(0x74E28d6915b4B61314A4f2Ac6bEA391e46fCAb22);
        // deploy contract
        //RockToken rocktoken = new RockToken(msg.sender);
        Bank bank = new Bank(msg.sender, address(rocktoken), 50);
        vm.stopBroadcast();
    }
}

// token 0x74E28d6915b4B61314A4f2Ac6bEA391e46fCAb22
// bank 0x13D3C38eacd8fe1315EdD95d4825302692d8A201
//onwer 0xCA399E71793dE7b5E96266F23D98c121d230Cf66
