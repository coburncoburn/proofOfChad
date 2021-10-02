
const hre = require("hardhat");

async function main() {
  const Chad = await hre.ethers.getContractFactory("Chadliness");
  const chad = await Chad.attach("0xA3C401cE4c21aEECD9e5D491061c3fFb066cBC85");

  let x = await chad.mint("0x6f762709A7eA8Ee00246Cd904A8228F06B57AAc1", "0x3a4169a6aaf8da3a47c902b7cb230f9a59af4aee12c9f8b3890826255f3c088c");

  console.log("chad minted to" + x);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
