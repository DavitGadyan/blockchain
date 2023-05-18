 // SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import "./Owned.sol";
import "./Logger.sol";
 import "./IFaucet.sol";

contract Faucet is Owned, Logger, IFaucet {
     // storage variables
    //  uint public funds = 1000;

    // special function
    // called when make tx that does not specify function
    // external are parts of contract interface
    // can be called by other contracts and transactions

    // create address
    // address[] public funders;
    uint public numOfFunders;


    mapping(address => bool) private funders;
    mapping(uint => address) private lutFunders;


    // payable can provide value
   receive() external payable {}

   function emitLog() public override pure returns(bytes32) {
     return "Hello World";
   }

   function addFunds() override external payable {
     address funder = msg.sender;

     if (!funders[funder]) {
       uint index = numOfFunders++;
       funders[funder] = true;
       lutFunders[index] = funder;
     }
   }

    modifier limitWithdraw(uint withdrawAmount){
        require(withdrawAmount <= 100000000000000000, "Cannot withdraw more than 0.1 ETH");
        _;
    }
   // withdraw fund from SC to account
   function withdraw(uint withdrawAmount) override external limitWithdraw(withdrawAmount){
        // require(withdrawAmount <= 100000000000000000, "Cannot withdraw more than 0.1 ETH");
    
    payable(msg.sender).transfer(withdrawAmount);
   }

    // function getAllFunders() external view returns(address[] memory){
    //     return funders;
    // }

     function getFunderAtIndex(uint8 index) external view returns(address) {
     return lutFunders[index];
   }

    function getAllFunders() external view returns (address[] memory) {
        address[] memory _funders = new address[](numOfFunders);

        for (uint i = 0; i < numOfFunders; i++) {
        _funders[i] = lutFunders[i];
        }

        return _funders;
    }

    function transferOwnership(address newOwner) external onlyOwner{
        owner = newOwner;
    }

    function test() external onlyOwner {

    }
}

 // Nonce a hash when combined with minHash proofs that
 // block has gine through proof of work(POW)
 // 8 bytes 64 bits

 // const instance = await Faucet.deployed();
 // instance.addFunds({from: accounts[2], value: "2000000000000000000"})

 // instance.withdraw("500000000000000000", {from: accounts[9]})