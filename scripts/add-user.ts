import { ethers } from "hardhat";

type Location = {
  lat: number;
  lng: number;
}

const Noida = { lat: 28.535517, lng: 77.391029 }
const Delhi = { lat: 28.704060, lng: 77.102493 }
const NewYork = { lat: 40.712776, lng: -74.005974 }
const Argentina = { lat: -47.067197, lng: -69.408051 }

const compressCoordinates = (location: Location): number => {
  const WEI = 100000000
  return ((location.lat + 90) * 180 + location.lng) * WEI;
}

const web3StringToBytes32 = (text: string) => {
  var result = ethers.utils.hexlify(ethers.utils.toUtf8Bytes(text));
  while (result.length < 66) { result += '0'; }
  if (result.length !== 66) { throw new Error("invalid web3 implicit bytes32"); }
  console.log('result', result)
  return result;
}

async function main() {
  // Library deployment
  const lib = await ethers.getContractFactory("BinarySearchTree");
  const libInstance = await lib.deploy();
  await libInstance.deployed();
  console.log("Library Address--->" + libInstance.address)

  const Fairplay = await ethers.getContractFactory("Fairplay", { libraries: { BinarySearchTree: libInstance.address } });
  const fairplay = await Fairplay.deploy();

  await fairplay.deployed();
  const [Mike] = await ethers.getSigners();
  await fairplay.connect(Mike).addUser(web3StringToBytes32('Mike'), new Date('01-03-1991').getTime(), 0, compressCoordinates(NewYork));
  // await fairplay.getUser();

  console.log(
    `Fairplay deployed to ${fairplay.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
