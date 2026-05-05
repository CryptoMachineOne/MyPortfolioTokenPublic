# 🪙 MyPortfolioToken (MPT)

ERC20 capped token smart contract built with Solidity using OpenZeppelin libraries.

## 📌 Overview

**MyPortfolioToken (MPT)** is a simple ERC20 token developed as a portfolio project.
It demonstrates core token mechanics including capped supply, controlled minting, and token burning.

This project showcases best practices in smart contract development such as using audited libraries and implementing basic access control.

---

## ⚙️ Features

* ✅ ERC20 standard implementation
* 🔒 Capped total supply (max 2,000,000 tokens)
* 👤 Owner-controlled minting
* 🔥 Token burning (deflation mechanism)
* 🧱 Built using OpenZeppelin Contracts

---

## 🛠 Tech Stack

* Solidity ^0.8.24
* OpenZeppelin Contracts
* Foundry (recommended for testing)

---

## 📂 Project Structure

```
.
├── src/
│   └── MyPortfolioToken.sol
├── test/
│   └── MyPortfolioToken.t.sol
├── README.md
```

---

## 🚀 Getting Started

### 1. Install Foundry

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

---

### 2. Clone the repository

```bash
git clone https://github.com/CryptoMachineOne/MyPortfolioTokenPublic.git
cd MyPortfolioTokenPublic
```

---

### 3. Install dependencies

```bash
forge install
```

---

### 4. Build the project

```bash
forge build
```

---

### 5. Run tests

```bash
forge test
```

---

## 📜 Contract Details

* **Name:** MyPortfolioToken
* **Symbol:** MPT
* **Initial Supply:** 1,000,000 tokens
* **Max Supply:** 2,000,000 tokens

---

## 🔐 Access Control

The contract uses an ownership model:

* Only the **owner** can mint new tokens
* Minting is limited by the capped supply

---

## 🔥 Burning

Any token holder can burn their own tokens:

```solidity
token.burn(amount);
```

This reduces the total token supply.

---

## 💰 Minting

Only the owner can mint new tokens:

```solidity
token.mint(user, amount);
```

Minting cannot exceed the maximum supply cap.

---

## ⚠️ Limitations

* The contract owner has full control over minting
* No governance or decentralization mechanisms
* No advanced tokenomics (staking, rewards, etc.)

---

## 📈 Future Improvements

* Add role-based access control (AccessControl)
* Add events for minting and burning
* Implement governance features
* Add deployment scripts
* Integrate frontend (dApp)

---

## 📄 License

MIT



            ////Code /////

            // SPDX-License-Identifier: MIT

            pragma solidity ^0.8.24;

            import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
            import "@openzeppelin/contracts/access/Ownable.sol";

            contract MyPortfolioToken is ERC20Capped, Ownable {

            constructor()
    ERC20("MyPortfolioToken", "MPT")
    ERC20Capped(2_000_000 * 10 ** decimals())
    Ownable(msg.sender)
            {
            `_mint(msg.sender, 1_000_000 * 10 ** decimals());
            }

            function mint(address to, uint256 amount) external onlyOwner {
    _mint(to, amount);
            }

            function burn(uint256 amount) external {
                _burn(msg.sender, amount);
            }

            }
            
