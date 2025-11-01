require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
  networks: {
    alfajores: {
      url: "https://alfajores-forno.celo-testnet.org",
      // Bạn sẽ cần thêm PRIVATE_KEY vào file .env
      accounts: [process.env.PRIVATE_KEY]
    }
  }
};