// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract FeeCollector {
    // Defining the state variables for the owner and balance:
    address public owner;
    uint256 public balance;

    // Setting the constructor to initialize the owner as the one deploying the smart contract:
    constructor() {
        owner = msg.sender;
    }

    // Defining the recieve function as payable to be able to transact with the function:
    receive() payable external {
        // Setting the balance equal to (balance + amount sent): 
        balance += msg.value;
    }

    // Defining a function modifier for authentication :
    modifier Auth(uint amount) {
        // Using require to only allow the owner to withdraw :
        require(msg.sender == owner, "Only owner can withdraw");
        
        // If the amount to be withdrawed is greater then balance , give an error.
        require(amount <= balance, "Insufficent funds");
        
        // Execute the rest of the function.
        _;
    }

    // Defining a function to withdraw, defining destAddr as payable to transact.
    function withdraw(uint amount, address payable destAddr) public Auth(amount) {
        destAddr.transfer(amount);      // Transferring to destination address.
        balance -= amount;      //Updating the balance.
    }
}
