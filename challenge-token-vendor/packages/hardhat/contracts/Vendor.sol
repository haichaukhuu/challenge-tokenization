pragma solidity 0.8.20; //Do not change the solidity version as it negatively impacts submission grading
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {
    /////////////////
    /// Errors //////
    /////////////////

    error InvalidEthAmount();
    error InsufficientVendorTokenBalance(uint256 available, uint256 required);
    error EthTransferFailed(address to, uint256 amount);
    error InvalidTokenAmount();
    error InsufficientVendorEthBalance(uint256 available, uint256 required);

    //////////////////////
    /// State Variables //
    //////////////////////

    YourToken public immutable yourToken;
    uint256 public constant tokensPerEth = 100;

    ////////////////
    /// Events /////
    ////////////////

    event BuyTokens(address indexed buyer, uint256 amountOfETH, uint256 amountOfTokens);
    event SellTokens(address indexed seller, uint256 amountOfTokens, uint256 amountOfETH);

    ///////////////////
    /// Constructor ///
    ///////////////////

    constructor(address tokenAddress) Ownable(msg.sender) {
        yourToken = YourToken(tokenAddress);
    }

    ///////////////////
    /// Functions /////
    ///////////////////

    /**
     * @notice Buy tokens by sending ETH
     * @dev Tokens are sold at tokensPerEth rate (100 tokens per 1 ETH)
     */
    function buyTokens() external payable {
        // Reject 0 ETH purchases
        if (msg.value == 0) {
            revert InvalidEthAmount();
        }

        // Calculate amount of tokens to give
        uint256 amountOfTokens = msg.value * tokensPerEth;

        // Check if vendor has enough tokens
        uint256 vendorBalance = yourToken.balanceOf(address(this));
        if (vendorBalance < amountOfTokens) {
            revert InsufficientVendorTokenBalance(vendorBalance, amountOfTokens);
        }

        // Transfer tokens to buyer
        yourToken.transfer(msg.sender, amountOfTokens);

        // Emit event
        emit BuyTokens(msg.sender, msg.value, amountOfTokens);
    }

    /**
     * @notice Owner can withdraw all ETH from the vendor
     */
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        address ownerAddress = owner();
        
        (bool success, ) = ownerAddress.call{value: balance}("");
        if (!success) {
            revert EthTransferFailed(ownerAddress, balance);
        }
    }

    /**
     * @notice Sell tokens back to the vendor for ETH
     * @param amount The amount of tokens to sell
     */
    function sellTokens(uint256 amount) public {
        // Reject 0 token sales
        if (amount == 0) {
            revert InvalidTokenAmount();
        }

        // Calculate ETH to return
        uint256 amountOfETH = amount / tokensPerEth;

        // Check if vendor has enough ETH
        uint256 vendorEthBalance = address(this).balance;
        if (vendorEthBalance < amountOfETH) {
            revert InsufficientVendorEthBalance(vendorEthBalance, amountOfETH);
        }

        // Transfer tokens from seller to vendor (requires prior approval)
        yourToken.transferFrom(msg.sender, address(this), amount);

        // Send ETH to seller
        (bool success, ) = msg.sender.call{value: amountOfETH}("");
        if (!success) {
            revert EthTransferFailed(msg.sender, amountOfETH);
        }

        // Emit event
        emit SellTokens(msg.sender, amount, amountOfETH);
    }
}
