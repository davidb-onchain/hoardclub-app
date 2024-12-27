// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract HoardToken is ERC20PresetMinterPauser {
    // Roles
    bytes32 public constant FEE_MANAGER_ROLE = keccak256("FEE_MANAGER_ROLE");
    
    // Fee configuration
    uint256 public transferFeeRate; // Fee rate in basis points (1/10000)
    address public feeCollector;
    
    // Events
    event FeeRateUpdated(uint256 oldRate, uint256 newRate);
    event FeeCollectorUpdated(address oldCollector, address newCollector);
    event FeesCollected(address indexed from, address indexed to, uint256 amount);

    constructor(
        string memory name,
        string memory symbol,
        address initialFeeCollector
    ) ERC20PresetMinterPauser(name, symbol) {
        require(initialFeeCollector != address(0), "Fee collector cannot be zero address");
        
        _grantRole(FEE_MANAGER_ROLE, _msgSender());
        feeCollector = initialFeeCollector;
        transferFeeRate = 100; // Default 1% fee (100 basis points)
        
        // Mint initial supply to deployer
        _mint(_msgSender(), 1000000000 * 10**decimals());
    }

    function setTransferFeeRate(uint256 newFeeRate) external onlyRole(FEE_MANAGER_ROLE) {
        require(newFeeRate <= 1000, "Fee rate cannot exceed 10%");
        emit FeeRateUpdated(transferFeeRate, newFeeRate);
        transferFeeRate = newFeeRate;
    }

    function setFeeCollector(address newFeeCollector) external onlyRole(FEE_MANAGER_ROLE) {
        require(newFeeCollector != address(0), "Fee collector cannot be zero address");
        emit FeeCollectorUpdated(feeCollector, newFeeCollector);
        feeCollector = newFeeCollector;
    }

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal virtual override {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        // Calculate fee
        uint256 fee = (amount * transferFeeRate) / 10000;
        uint256 transferAmount = amount - fee;

        // Transfer main amount
        super._transfer(sender, recipient, transferAmount);

        // Transfer fee if applicable
        if (fee > 0) {
            super._transfer(sender, feeCollector, fee);
            emit FeesCollected(sender, recipient, fee);
        }
    }

    // Function to recover tokens accidentally sent to the contract
    function recoverTokens(IERC20 token, uint256 amount) external onlyRole(DEFAULT_ADMIN_ROLE) {
        require(address(token) != address(this), "Cannot recover HOARD tokens");
        token.transfer(_msgSender(), amount);
    }
}