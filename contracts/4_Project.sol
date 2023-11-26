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
        
    } //
    // Now selecting winner on random basis
    function random() public view returns(uint)
    {
        return uint(keccak256(abi.encodePacked(block.prevrandao,block.timestamp,participants.length)));  // this is a function which geneates random numbers
    }
    //Now a very big random number is generated but we need only index of a particular participant(winner)

    function selectWinner() public
    {
        require(msg.sender==manager);
        require(participants.length>=3);
        uint r =random();
        uint index = r%participants.length;  // by this humari jo badi value thi woh choti hogayi
        address payable winner;
        winner = participants[index];     
    // So we got the winner selected now transfer funds
        winner.transfer(getBalanceofContract());  
    // Now reset the contract 
    participants = new address payable[](0);
    }
  



}