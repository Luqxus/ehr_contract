import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import dotenv from "dotenv"
dotenv.config()

let API_KEY= process.env.API_KEY;
let PRIVATE_KEY = process.env.PRIVATE_KEY;
let API_URL = process.env.API_URL;

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    sepolia: {
      url: `${API_URL}${API_KEY}`,
      accounts: [`${PRIVATE_KEY}`],
    }
  }
};

export default config;
