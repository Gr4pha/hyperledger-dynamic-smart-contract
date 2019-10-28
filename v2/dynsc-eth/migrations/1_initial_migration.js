const A = artifacts.require("Base");
const B = artifacts.require("Satellite");
const C = artifacts.require("Satellite1");
const D = artifacts.require("Satellite2");

module.exports = function(deployer) {
  deployer.deploy(D);
  deployer.deploy(C);
  deployer.deploy(B);
  deployer.deploy(A);
};
