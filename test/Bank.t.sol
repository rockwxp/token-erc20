// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/Bank.sol";
import "../src/RockToken.sol";

contract BankTest is Test {
    RockToken public token;
    Bank public bank;
    address public owner;
    address public user_1;

    function setUp() public {
        owner = address(1);
        user_1 = address(2);
        token = new RockToken(owner);
        bank = new Bank(owner, address(token), 50);
        vm.startPrank(owner);
        token.mint(user_1, 100);
        console.log("user_1 balance: ", token.balanceOf(user_1));
        vm.stopPrank();
        vm.startPrank(user_1);
        token.approve(address(bank), 80);
        vm.stopPrank();
    }

    function testDeposit() public {
        vm.startPrank(user_1);
        bank.deposit(12);
        console.log("user_1 balance: ", token.balanceOf(user_1));
        console.log("bank balance: ", token.balanceOf(address(bank)));
        bank.withdraw(10);
        console.log("user_1 balance: ", token.balanceOf(user_1));
        console.log("bank balance: ", token.balanceOf(address(bank)));
        bank.deposit(60);
        console.log("user_1 balance: ", token.balanceOf(user_1));
        console.log("bank balance: ", token.balanceOf(address(bank)));
        vm.stopPrank();

        bank.autoWithdraw();
        console.log("bank balance: ", token.balanceOf(address(bank)));
        console.log("owner balance: ", token.balanceOf(owner));
    }
}
