# MyPortfolioToken (MPT)

ERC20 capped token smart contract built with Solidity using OpenZeppelin libraries.

## 📌 Overview

MyPortfolioToken (MPT) is a simple ERC20 token designed as a portfolio project.
It demonstrates capped supply, controlled minting, and token burning.

## ⚙️ Features

* ERC20 standard implementation
* Capped total supply (max 2,000,000 tokens)
* Initial supply minted at deployment
* Owner-controlled minting
* Token burning (deflation mechanism)
* Built with OpenZeppelin Contracts

## 🛠 Tech Stack

* Solidity ^0.8.24
* OpenZeppelin Contracts

## 🚀 Deployment

You can deploy the contract using:

* Remix IDE
* Hardhat
* Foundry

### Example (Remix)

1. Open Remix IDE
2. Paste the contract
3. Compile with Solidity ^0.8.24
4. Deploy the contract

## 📜 Contract Details

* **Name:** MyPortfolioToken
* **Symbol:** MPT
* **Initial Supply:** 1,000,000 tokens
* **Max Supply:** 2,000,000 tokens

## 🔐 Access Control

* Only the contract owner can mint new tokens
* Minting is limited by the capped supply

## 🔥 Burning

Users can burn their own tokens, reducing total supply.

## ⚠️ Notes

* The contract owner has control over minting remaining tokens
* This project is intended for educational and portfolio purposes

## 📄 License

MIT


            ////Code /////

            // SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol"; import "@openzeppelin/contracts/access/Ownable.sol";

contract MyPortfolioToken is ERC20Capped, Ownable {

constructor()
    ERC20("MyPortfolioToken", "MPT")
    ERC20Capped(2_000_000 * 10 ** decimals())
    Ownable(msg.sender)
{
    _mint(msg.sender, 1_000_000 * 10 ** decimals());
}

function mint(address to, uint256 amount) external onlyOwner {
    _mint(to, amount);
}

function burn(uint256 amount) external {
    _burn(msg.sender, amount);
}

}
