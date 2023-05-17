 // SPDX-License-Identifier: MIT
 pragma solidity >=0.4.22 <0.9.0;

 contract Faucet {
     // storage variables
    //  uint public funds = 1000;

    // special function
    // called when make tx that does not specify function
    // external are parts of contract interface
    // can be called by other contracts and transactions

    // create address
    // address[] public funders;
    uint public numOfFunder;

    mapping (uint => address) public funders;


    // payable can provide value
    receive() external payable {
    }

    function addFunds () external payable {
        // funders.push(msg.sender);
        uint index = numOfFunder++;
        funders[index] = msg.sender;
    }

    // function getAllFunders() external view returns(address[] memory){
    //     return funders;
    // }

    function getFunderAtIndex (uint index) external view returns(address){
        return funders[index];
    }
}

 // Nonce a hash when combined with minHash proofs that
 // block has gine through proof of work(POW)
 // 8 bytes 64 bits