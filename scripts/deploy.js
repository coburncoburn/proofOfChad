// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const Chad = await hre.ethers.getContractFactory("Chadliness");
  const chad = await Chad.deploy();

  await chad.deployed();

  await chad.mint("0x2e4ae4d3bd0af45040b4f17e0bb7e6dc548626b1", "0x3a4169a6aaf8da3a47c902b7cb230f9a59af4aee12c9f8b3890826255f3c088c");

  console.log("chad deployed to:", chad.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
