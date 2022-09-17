// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract FeeCollector {
    address public owner;
    uint256 public balance;

    constructor() {
        owner = msg.sender;
    }

    receive() payable external {
        balance += msg.value;
    }

    modifier Auth(uint amount) {
        require(msg.sender == owner, "Only owner can withdraw");
        require(amount <= balance, "Insufficent funds");
        _;
    }

    function withdraw(uint amount, address payable destAddr) public Auth(amount) {
        destAddr.transfer(amount);
        balance -= amount;
    }
}