import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";
import { ethers } from "hardhat/";
import { DiceGame, RiggedRoll } from "../typechain-types";

const deployRiggedRoll: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployer } = await hre.getNamedAccounts();
  const { deploy } = hre.deployments;

  const diceGame: DiceGame = await ethers.getContract("DiceGame");
  const diceGameAddress = await diceGame.getAddress();

  // Deploy RiggedRoll contract
  await deploy("RiggedRoll", {
    from: deployer,
    log: true,
    args: [diceGameAddress],
    autoMine: true,
  });

  const riggedRoll: RiggedRoll = await ethers.getContract("RiggedRoll", deployer);

  // Transfer ownership to deployer (already the owner, but this is here for when you want to set a specific frontend address)
  // To set your frontend address as owner, replace deployer with your address string
  // try {
  //   await riggedRoll.transferOwnership("Your Frontend Address");
  // } catch (err) {
  //   console.log(err);
  // }
};

export default deployRiggedRoll;

deployRiggedRoll.tags = ["RiggedRoll"];
