// License
// SPDX-License-Identifier: GPL-3.0

// Solidity version
pragma solidity 0.8.24;

//  Functions:
    // 1. Deposit ether
    // 2. Withdraw ether


// Rules:
    // 1. Multiuser
    // 2. Only can deposit ether
    // 3. Only can withdraw own ether
    // 4. Max balance per user 5 ether
    // 5. MaxBalance modifiable by owner

    // UserA -> Deposit (5 ether)
    // UserB -> Deposit (2 ether)
    // Bank balance = 7 ether

contract CryptoBank {

    // Variables
    uint256 public maxBalance;
    address public admin;
    mapping(address => uint256) public userBalance;

    // Events
    event EtherDeposit(address user_, uint256 etheramount_);
    event EtherWithdraw(address user_, uint256 etheramount_);

    // Modifiers
    modifier onlyAdmin() {
        require(msg.sender == admin, "Not allowed");
        _;
    }

    constructor(uint256 maxBalance_, address admin_) {
        maxBalance = maxBalance_;
        admin = admin_;
    }

    // Functions

        // External

    // 1. Deposit
    function depositEther() external payable {
        require(userBalance[msg.sender] + msg.value <= maxBalance, "MaxBalance reached");
        userBalance[msg.sender] += msg.value;
        emit EtherDeposit(msg.sender, msg.value);
    }

    // 2. Withdraw
    function withdrawEther(uint256 amount_) external {
        require(userBalance[msg.sender] >= amount_, "Not enough ether");
        // CEI pattern:
        //  1. Checks
        //  2. Effects (Update States)
        //  3. Interactions
        // Avoid reentrancy attacks

        // 1. Update state
        userBalance[msg.sender] -= amount_;

        // 2. Transfer ether
        (bool success,) = msg.sender.call{value: amount_}("");
        require(success, "Transfer failed");

        // 3. Emit event
        emit EtherWithdraw(msg.sender, amount_);
    }

    // 3. Modify maxBalance

    function modifyMaxBalance(uint256 newMaxBalance_) external onlyAdmin {
        maxBalance = newMaxBalance_;
    }

}