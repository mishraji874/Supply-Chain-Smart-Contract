# Supply Chain Smart Contract

This smart contract facilitates secure and transparent management of your supply chain on a blockchain network. Features include:

- **Traceability & Anti-Counterfeiting:** Track goods throughout their journey, ensuring authenticity and preventing fraud.
- **Automated Workflows:** Automate key processes like order creation, shipment tracking, and payment releases.
- **Enhanced Visibility:** Gain real-time insights into the location and status of goods, improving collaboration and logistics efficiency.
- **Reduced Costs:** Eliminate intermediaries and streamline processes for potential cost savings.

## Getting Started:

### Installation and Deployment

1. Clone the repository:
   ```bash
   git clone https://github.com/mishraji874/Supply-Chain-Smart-Contract.git
2. Navigate to the project directory:
    ```bash
    cd Supply-Chain-Smart-Contract
3. Initialize Foundry and Forge:
    ```bash
    forge init
4. Create the ```.env``` file and paste the [Alchemy](https://www.alchemy.com/) api for the Sepolia Testnet and your Private Key from the Metamask.

5. Compile and deploy the smart contracts:

    If you want to deploy to the local network anvil then run this command:
    ```bash
    forge script script/DeploySupplyChain.s.sol --rpc-url {LOCAL_RPC_URL} --private-key {PRIVATE_KEY}
    ```
    If you want to deploy to the Sepolia testnet then run this command:
    ```bash
    forge script script/DeploySupplyChain.s.sol --rpc-url ${SEPOLIA_RPC_URL} --private-key ${PRIVATE_KEY}
### Running Tests

Run the automated tests for the smart contract:

```bash
forge test
```

## Configuration:

This is a base implementation. You can extend it to include features like:

- Role-based access control for different participants in the supply chain.
- Integration with external data oracles for real-world data feeds.
- Support for different types of goods and transactions.

## Additional Notes:

- Refer to the SupplyChain.sol and SupplyChainTest.t.sol files for detailed contract logic and test cases.
- Consider seeking legal and regulatory advice for deploying this smart contract in a production environment.