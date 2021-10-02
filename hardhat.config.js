require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.0",

  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://bscscan.com/
    apiKey: "TPARIWXYK46KEA1R2GKVAKN7KPJKJFDTNN"
  },
  networks: {
    ropsten: {
      url: `https://ropsten-eth.compound.finance`,
      accounts: ["0x5ba6e405a2e34c7375a3cced62e9cd5bcec1fc959677fa3fa2e57a58c41e768f"]
    },
    rinkeby: {
      url: `https://rinkeby-eth.compound.finance`,
      accounts: [""]
    },
  },
};