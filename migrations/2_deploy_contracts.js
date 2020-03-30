//const Springboard = artifacts.require("Springboard");
//const Wallet = artifacts.require("Wallet");
//const WalletV2 = artifacts.require("WalletV2");
const Airdrop = artifacts.require("Airdrop");

module.exports = function(deployer) {
  deployer.deploy(Airdrop);
};
