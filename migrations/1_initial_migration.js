const IsalToken = artifacts.require("IsalToken");

module.exports = function (deployer) {
  deployer.deploy(IsalToken);
};
