# 🏦 CryptoBank – Secure Multiuser Ether Vault in Solidity

![Solidity](https://img.shields.io/badge/Solidity-0.8.24-blue?style=flat&logo=solidity)
![License](https://img.shields.io/badge/License-GPL--3.0-green?style=flat)
![Platform](https://img.shields.io/badge/Platform-Remix-blueviolet)

## 📌 Description

`CryptoBank` is a simple multi-user Ether vault built in Solidity. It allows multiple users to deposit and withdraw Ether securely under constraints set by the contract admin.

Designed to be tested and interacted with using **Remix IDE**, this contract showcases good practices like **access control**, **user-level isolation**, and the **Checks-Effects-Interactions (CEI)** pattern for safe Ether withdrawals.

---

## 🧱 Features

- 👥 Multiuser: each user has an isolated balance
- 💰 Only deposits Ether (no tokens)
- 🔐 Users can only withdraw their own funds
- 🧱 Enforces a per-user `maxBalance` limit (modifiable by admin)
- 🛡️ Uses CEI pattern to protect against reentrancy attacks

---

## 📁 Project Structure

```
├── CryptoBank.sol     # Main contract (Remix-ready)
```

---

## 🧪 Contract Overview

### Constructor

```solidity
constructor(uint256 maxBalance_, address admin_)
```

- Sets initial per-user maximum balance
- Assigns admin role

---

### Deposit Ether

```solidity
function depositEther() external payable
```

- Increases sender’s balance
- Requires not exceeding `maxBalance`

---

### Withdraw Ether

```solidity
function withdrawEther(uint256 amount_) external
```

- Only allows withdrawal if user has enough balance
- Applies CEI pattern to prevent reentrancy

---

### Modify Max Balance

```solidity
function modifyMaxBalance(uint256 newMaxBalance_) external onlyAdmin
```

- Can only be called by admin
- Updates the `maxBalance` allowed per user

---

## 📤 Example Usage

```solidity
// User deposits
cryptoBank.depositEther{value: 2 ether}();

// User withdraws
cryptoBank.withdrawEther(1 ether);

// Admin updates limit
cryptoBank.modifyMaxBalance(10 ether);
```

---

## 🔐 Security Notes

- Applies CEI pattern for withdrawals
- Avoids global balance state (each user isolated)
- Uses `call{value: amount}` for safe ETH transfers

---

## 📄 License

Licensed under the **GNU General Public License v3.0** – see the [`LICENSE`](./LICENSE) file.

---

## 📬 Contact

Open an issue or reach out to suggest improvements, report bugs, or discuss extensions (e.g., time-locked deposits, interest, multisig withdrawals).
