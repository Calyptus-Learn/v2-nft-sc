# Calyptus NFT Contracts

## Testing

Tests are written to cover as many scenarios as possible but not enough to stop here.

To run the tests, you will have to do the following

1. Clone this repository to your local machine.
2. Run `forge install`.
3. Run `forge build`.
4. Run `forge test`.

OR, you can just run `forge test`, which will automatically install dependencies and compile the contracts.

## Deploying

To deploy the contract, you will have to do the following

1. Clone this repository to your local machine.
2. Run `forge install && npm install`.
3. Create the `.env` file based on the `.env.example`.
4. Modify network options in `hardhat.config.js`.
5. Deploy the smart contract with ` npx hardhat run scripts/deploy.ts --network {network name}`
6. Verify the deployed contract(if needed) using `npx hardhat verify --network {network} {DEPLOYED_CONTRACT_ADDRESS} "{Constructor argument}"
`

If you would like to deploy it locally, make sure to run `npx hardhat node` before the 3rd step, and deploy the smart contract with `localhost` as the "network name"

If you would like to upgrade the already deployed proxy, make sure to:

1. Modify the `PROXY` variable in `.env`.
2. Upgrade the smart contract with ` npx hardhat run scripts/upgrade.ts --network {network name}`
3. Verify the deployed contract(if needed) using `npx hardhat verify --network {network} {DEPLOYED_CONTRACT_ADDRESS} "{Constructor argument}"
`
