require("@nomicfoundation/hardhat-toolbox");
require("hardhat-deploy");
require("dotenv").config();

const RCP_PRIVATE_KEY = process.env.RCP_PRIVATE_KEY;
const RCP_GOERLI_URL = process.env.RCP_GOERLI_URL;

module.exports = {
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      chainId: 31337,
      blockConfirmations: 1,
    },
  },
  solidity: "0.8.17",
  mocha: {
    timeout: 200000,
  },
  namedAccounts: {
    deployer: {
      default: 0,
    },
    player: {
      default: 1,
    },
  },
};
