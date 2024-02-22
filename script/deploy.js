const { upgrades, ethers } = require("hardhat");
require("dotenv").config();

const main = async () => {
  const address = process.env.OWNER_ADDRESS;

  const CalyptusNFTFactory = await ethers.getContractFactory("CalyptusNFT");
  const calyptusNFT = await upgrades.deployProxy(
    CalyptusNFTFactory,
    [address],
    {
      kind: "uups",
    }
  );

  await calyptusNFT.waitForDeployment();

  const CalyptusNFTAddress = await calyptusNFT.getAddress();

  console.log(`CalyptusNFT Proxy Deployed on Address: ${CalyptusNFTAddress}`);
};

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
