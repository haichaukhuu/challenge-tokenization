pragma solidity 0.8.20; //Do not change the solidity version as it negatively impacts submission grading
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// learn more: https://docs.openzeppelin.com/contracts/5.x/erc20

contract YourToken is ERC20 {
    constructor() ERC20("Gold", "GLD") {
        // Mint 1000 tokens (with 18 decimals) to the deployer
        _mint(msg.sender, 1000 * 10 ** 18);
    }
}
