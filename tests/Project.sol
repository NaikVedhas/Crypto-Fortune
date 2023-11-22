// SPDX-License-Identifier: MIT
pragma solidity  >=0.5.0<0.9.0;  

contract Lottery{

    address public manager;
    address payable[] public participants;   // we made an array bec participants are more than 1

    constructor(){

        manager= msg.sender;   // This means it is the boss 
    }
    receive() external payable { 
        
        if (msg.value== 2 ether) {                
        participants.push(payable(msg.sender));   // pushed the address of participant when he send us money 
            
        }
    }
    function getBalanceofContract() view public returns(uint)
    {
        require(msg.sender==manager);    // msg.sender will be the person who's currently connecting with the contract.
        return address(this).balance;    // By this only manager can view the balance
        
    }
    // Now selecting winner on random basis
    function random() public view returns(uint)
    {
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));  // this is a function which geneates random numbers
    }
    //Now a very big random number is generated but we need only index of a particular participant(winner)

    function selectWinner() public view returns(address)
    {
        require(msg.sender==manager);
    }






}