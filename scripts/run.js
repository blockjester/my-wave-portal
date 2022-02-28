// npx hardhat run scripts/deploy.js --network rinkeby
// Deploying contracts with account:  0x72691d2fC7E211fFeD9788794Df95051780a8bfb
// Account balance:  100000000000000000
// WavePortal address:  0xB178a26049AFAa63569761fd9DD2AD945Cc0a527
const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.utils.parseEther("1"),
  });
  await waveContract.deployed();
  console.log("Contract deployed to:", waveContract.address);
  console.log("Contract deployed by:", owner.address);
  
  // Show initial balance of contract
  let contractBalance = await hre.ethers.provider.getBalance(
    waveContract.address
  );
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  // Try two waves
  let waveTxn = await waveContract.wave("Wave 1!");
  await waveTxn.wait();
  
  function sleep(ms) {
    return new Promise((resolve) => {
      setTimeout(resolve, ms);
    });
  }

  await sleep(4000);
  let waveTxn2 = await waveContract.wave("Wave 2!");
  await waveTxn2.wait();

  /*
   * Get Contract balance to see what happened!
   */
  contractBalance = await hre.ethers.provider.getBalance(
    waveContract.address
  );
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  let allWaves = await waveContract.getAllWaves();
  console.log(allWaves);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();