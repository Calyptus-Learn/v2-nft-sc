require("@nomicfoundation/hardhat-foundry");
require("@openzeppelin/hardhat-upgrades");
require("@nomicfoundation/hardhat-ethers");
require("@nomicfoundation/hardhat-verify");

require("dotenv").config();

module.exports = {
  solidity: {
    version: "0.8.20",
    settings: {
      optimizer: {
        enabled: true,
        runs: 1000000,
      },
    },
  },
  networks: {
    sepolia: {
      chainId: 11155111,
      url: String(process.env.POLYGON_MUMBAI_RPC_URL),
      accounts: [process.env.DEPLOYER_PRIVATE_KEY || ""],
    },
    localhost: {
      // url: "http://127.0.0.1:8545", // Localhost (default: Hardhat network)
      // chainId: 1337, // Standard chain ID for Hardhat's local network
    },
    arbitrum_nova: {
      chainId: 42170,
      url: String(process.env.ARBITRUM_NOVA_RPC_URL),
      accounts: [process.env.DEPLOYER_PRIVATE_KEY || ""],
    },
  },
  etherscan: {
    apiKey: {
      sepolia: String(process.env.POLYGONSCAN_API_KEY),
    },
    apiKey: {
      arbitrum_nova: String(process.env.ARBITRUM_NOVA_API_KEY),
    },
    customChains: [
      {
        network: "arbitrum_nova",
        chainId: 42170,
        urls: {
          apiURL: "https://api-nova.arbiscan.io/api",
          browserURL: "https://nova.arbiscan.io",
        },
      },
    ],
  },
  sourcify: {
    // Disabled by default
    // Doesn't need an API key
    enabled: true,
  },
};
