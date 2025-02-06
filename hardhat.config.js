require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-ethers");

require("dotenv").config();

module.exports = {
  solidity: "0.8.20",
  networks: {
    holesky: {
      url: process.env.HOLESKY_RPC_URL,
      accounts: [process.env.PRIVATE_KEY]
    }
  },
  etherscan: {
    apiKey: "NGG5TWQFC3A62WCYV1ZQEZFMS8UR8SKBWD"
  }
};
