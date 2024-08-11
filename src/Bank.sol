// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.24;

import "./RockToken.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Bank {
    address public token;
    address private owner;
    uint256 private autoWithdrawAmount;
    mapping(address => uint256) public balances;

    constructor(address _owner, address _token, uint256 _autoWithdrawAmount) {
        owner = _owner;
        token = _token;
        autoWithdrawAmount = _autoWithdrawAmount;
    }

    function deposit(uint256 amount) external {
        require(amount > 0, "invalid amount");
        IERC20(token).transferFrom(msg.sender, address(this), amount);
        balances[msg.sender] += amount;
    }

    function withdraw(uint256 amount) external {
        require(amount > 0, "invalid amount");
        require(balances[msg.sender] >= amount, "insufficient balance");
        balances[msg.sender] -= amount;
        IERC20(token).transfer(msg.sender, amount);
    }

    function autoWithdraw() external {
        require(
            IERC20(token).balanceOf(address(this)) > autoWithdrawAmount,
            "the balance is not reach the withdraw amount"
        );

        IERC20(token).transfer(
            owner,
            IERC20(token).balanceOf(address(this)) / 2
        );
    }

    //schedule function: check before execute
    function checkUpkeep(
        bytes calldata
    ) external view returns (bool upkeepNeeded) {
        upkeepNeeded =
            IERC20(token).balanceOf(address(this)) > autoWithdrawAmount;
    }

    // schedule function: execute
    function performUpkeep(bytes calldata) external {
        IERC20(token).transfer(
            owner,
            IERC20(token).balanceOf(address(this)) / 2
        );
    }
}
