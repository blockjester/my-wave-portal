// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
  uint256 totalWaves;
  uint256 private seed;

  event NewWave(address indexed from, uint256 timestamp, string message);

  struct Wave {
    address waver;
    string message;
    uint256 timestamp;
  }

  Wave[] waves;

  /*
  * This is an address => uint mapping, meaning I can associate an address with a number!
  * In this case, I'll be storing the address with the last time the user waved at us.
  */
  mapping(address => uint256) public lastWavedAt;

  constructor() payable {
    console.log("Yo yo, I am a contract and I am smart");
    seed = (block.timestamp + block.difficulty) % 100;
  }

  function wave(string memory _message) public {
    require(
      lastWavedAt[msg.sender] + 30 seconds < block.timestamp,
      "Wait 30 sec"
    );
    
    lastWavedAt[msg.sender] = block.timestamp;

    totalWaves++;
    console.log("%s has waved w/ message %s: " , msg.sender, _message);

    waves.push(Wave(msg.sender, _message, block.timestamp));

    /*
     * Generate a new seed for the next user that sends a wave
     */
    seed = (block.difficulty + block.timestamp + seed) % 100;

    console.log("Random # generated: %d", seed);

    if (seed <= 50) {
      console.log("%s won!", msg.sender);

      uint256 prizeAmount = 0.0001 ether;
      require(
        prizeAmount <= address(this).balance,
        "You don't have enough ether to pay for the prize"
      );
      (bool success, ) = (msg.sender).call{value: prizeAmount}("");
      require(success, "Failed to withdraw money from contract");
    }

    emit NewWave(msg.sender, block.timestamp, _message);
  }

  function getAllWaves() public view returns (Wave[] memory) {
    return waves;
  }

  function getTotalWaves() public view returns (uint256) {
    return totalWaves;
  }
}