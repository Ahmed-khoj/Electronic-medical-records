const Migrations = artifacts.require("EMR");

module.exports = function (deployer) {
  deployer.deploy(EMR);
};
