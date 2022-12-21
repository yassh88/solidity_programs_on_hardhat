const { expect, assert } = require("chai");
const { network, deployments, ethers } = require("hardhat");
const { describe } = require("node:test");
const { developmentChains } = require("../../helper-hardhat.config");

!developmentChains.includes(network.name)
  ? describe.skip
  : describe("piggyBank ", () => {
      let piggyBank, user, accounts;
      // const MIN_PRICE = ethers.utils.parseEther("0.1");
      beforeEach(async () => {
        accounts = await ethers.getSigners();
        user = accounts[0];
        await deployments.fixture(["all"]);
        piggyBank = await ethers.getContract("PiggyBank");
      });
      it.only("check is piggyBank successfully", async () => {
        const ownerAddress = await piggyBank.getOwner();
        assert(user.address.toString() === ownerAddress.toString());
      });
    });
