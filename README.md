## Overview (HOARD Token)
HOARD Token is an ERC20 token implementation built on the Ethereum blockchain using OpenZeppelin's battle-tested contracts. The token includes advanced features such as transfer fees, minting capabilities, burning mechanisms, and role-based access control.

## Technical Specifications

- **Token Name:** HOARD Token
- **Symbol:** $HOARD
- **Decimals:** 18
- **Total Supply:** 1,000,000,000 HOARD
- **Contract Standard:** ERC20
- **Solidity Version:** ^0.8.20
- **Framework:** Hardhat
- **Base Contract:** OpenZeppelin's ERC20PresetMinterPauser

## Features

- **Transfer Fees:** Configurable fee mechanism with dedicated fee collector
- **Access Control:** Role-based permissions for critical functions
- **Minting:** Controlled token minting by authorized addresses
- **Burning:** Token burning capabilities
- **Pausable:** Emergency pause functionality for transfers
- **Token Recovery:** Safety function to recover accidentally sent tokens

## Smart Contract Architecture

### Core Contracts

```
contracts/
├── HoardToken.sol          # Main token contract
├── interfaces/            # Contract interfaces
└── test/                 # Test contracts
```

### Roles

- DEFAULT_ADMIN_ROLE
- MINTER_ROLE
- PAUSER_ROLE
- FEE_MANAGER_ROLE

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

- Project Link: [https://github.com/davidb-onchain/hoardclub-app/tree/master](https://github.com/davidb-onchain/hoardclub-app/tree/master)
- Twitter: @hoardclub