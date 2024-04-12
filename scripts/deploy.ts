import { ethers } from "hardhat";

async function main() {

    const [deployer] = await ethers.getSigners();

    console.log(
    "Deploying contracts with the account:",
    deployer.address
    );

    const EHR = await ethers.getContractFactory("EHR");
    const contract = await EHR.deploy();

    console.log("Contract deployed at:", contract.getAddress());

    // const saySomething = await contract.speak();
    
    // console.log("saySomething value:", saySomething);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
