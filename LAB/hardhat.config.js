require("@nomicfoundation/hardhat-toolbox");
require("./tasks/index.js");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  defaultNetwork: "localhost",
  solidity: "0.8.28",
};
