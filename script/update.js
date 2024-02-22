const { upgrades, ethers } = require("hardhat");

const PROXY = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512";

const main = async () => {
  const CalyptusNFTV2 = await ethers.getContractFactory("CalyptusNFTV2");
  const calyptusNFTV2 = await upgrades.upgradeProxy(PROXY, CalyptusNFTV2);

  await calyptusNFTV2.waitForDeployment();

  console.log(
    `Implementation ${await calyptusNFTV2.version()} has been Deployed`
  );
};

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
