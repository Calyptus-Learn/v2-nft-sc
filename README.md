# On-Chain Resume by Calyptus

On-Chain Resume allows candidates to create, manage, and utilize digitalized resumes on the blockchain as NFTs (Non-Fungible Tokens). Below, you will find an overview of the platform's key features and use cases.

## Overview

The On-Chain Resume platform by Calyptus offers a solution for digitizing and securing candidate resumes on the blockchain. By creating a profile on the platform, users can generate a digital resume represented as an NFT with metadata showcasing their skills and qualifications.

## Key Features and Use Cases

### 1. Representation of Blockchain Links in the Profile

- **Blockchain Wallet Address**: Displayed in the user's profile.
- **NFT Explorer Link**: Displayed in the skills block, allowing easy access to view the NFT.

### 2. Metadata Compilation for NFT

- The [platform](calyptus.co) aggregates verified skill scores, assessment results, and endorsements to form the metadata attached to the NFT.

### 3. NFT Creation

- Once all necessary metadata is compiled, the [platform](calyptus.co) initiates the creation of an NFT that represents the digital resume on the blockchain. This occurs right after completing the onboarding process.

### 4. Dynamic NFT Metadata Updates

- When new skills assessments, confirmations, or skills are added to the user's profile, the metadata associated with the NFT is dynamically updated to reflect these changes.

### 5. NFT Ownership

- After the NFT is created, ownership is assigned to the candidate by transferring the NFT to the candidate's internal wallet provided by Calyptus or an external wallet added during the onboarding process.

### 6. NFT Verification from Calyptus

- An additional layer of verification from the Calyptus Platform can be added as metadata to the NFT, signaling that the data has been authenticated.

### 7. NFT Archival or Versioning

- If the metadata is decentralized, the platform offers the option for NFT mutability. Significant updates to the candidate's resume can result in new versions of the NFT being minted, with previous versions either archived or burned.

### 8. NFT Transferability

- Candidates have the ability to transfer the NFT from the internal wallet provided by Calyptus to an external wallet. This transfer can be done only once, and Calyptus covers the gas cost.

### 9. Audit Trail

- Each transaction or change related to the NFT, including dynamic metadata updates, is recorded immutably on the blockchain, providing a comprehensive audit trail.

For more details on how to use the On-Chain Resume platform and its smart contract, please contact our support team.

# Calyptus NFT Contracts

## Testing

Tests are written to cover as many scenarios as possible but not enough to stop here.

To run the tests, you will have to do the following

1. Clone this repository to your local machine.
2. Run `forge install`.
3. Run `forge build`.
4. Run `forge test`.

OR, you can just run `forge test`, which will automatically install dependencies and compile the contracts.

## Deployment

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
