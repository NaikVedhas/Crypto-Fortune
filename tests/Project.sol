// SPDX-License-Identifier: MIT
pragma solidity  >=0.5.0<0.9.0;  

contract Lottery{

    address public manager;
    address payable[] public participants;   // we made an array bec participants are more than 1

    constructor(){

        manager= msg.sender;   // This means is the boss 
    }
    receive() external payable { 
        
        if (msg.value== 2 ether) {                
        participants.push(payable(msg.sender));   // pushed the address of participant when he send us money 
            
        }
    }
    function getBalanceofContract() view public returns(uint)
    {
        if (msg.sender==manager) {        // msg.sender will be the person who's currently connecting with the contract.
        return address(this).balance;    // By this only manager can view the balance
        }
    }
    

}