var VotingRoom = artifacts.require("./VotingRoom.sol");

module.exports = function(deployer) {
  deployer.deploy(VotingRoom);
};
