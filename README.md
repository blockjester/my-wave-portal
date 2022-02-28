# Basic Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```
# Working with `waveportal-starter-project`

Run `npm run rinkeby` to deploy to Rinkeby testnet.

Run `npm run cp` to copy the ABI into waveportal-starter-project.

Run `npm run script` to test out the smart contract via scripts/run.js.

```shell
"clean": "npx hardhat clean",
"compile": "npx hardhat compile",
"console": "npx hardhat console",
"node": "npx hardhat node",
"rinkeby": "npx hardhat run scripts/deploy.js --network rinkeby",
"cp": "cp ./artifacts/contracts/WavePortal.sol/WavePortal.json ../waveportal-starter-project/src/utils",
"script": "npx hardhat run scripts/run.js",
"test": "npx hardhat test"
```