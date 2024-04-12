import { ethers } from 'hardhat';
import contract from '../artifacts/contracts/EHR.sol/EHR.json';
import dotenv from 'dotenv'; 
dotenv.config(); 


let PRIVATE_KEY;
if (process.env.PRIVATE_KEY) {
	PRIVATE_KEY = process.env.PRIVATE_KEY;
} else {
	PRIVATE_KEY = "";
} 


 const API_KEY = process.env.API_KEY;
 let CONTRACT_ADDRESS;
 if (process.env.CONTRACT_ADDRESS) {
	CONTRACT_ADDRESS = process.env.CONTRACT_ADDRESS;
} else {
	CONTRACT_ADDRESS = "";
} 
//  const NETWORK_URL = process.env.API_URL;


// console.log(contract.abi);


const infuraProvider = new ethers.InfuraProvider("sepolia", API_KEY)
const signer = new ethers.Wallet(PRIVATE_KEY, infuraProvider)
const ehrContract = new ethers.Contract(CONTRACT_ADDRESS, contract.abi, signer);



async function main() {
	const tx = ehrContract.createUser("Luqus", 28, ["Processed Meat"], "Type O")
	console.log(tx);
// string memory name,
// uint age,
// string[] memory allergies,
// string memory bloodType
}

main();