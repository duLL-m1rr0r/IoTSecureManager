# IoT Secure Manager

A simple smart contract demonstrates taking advantage of blockchain to ensecure IoT device data transmission.  
  
(Deployed on Goreli Testnet: https://goerli.etherscan.io/tx/0xb31f387e91dde6d8de7ad607b878bb3f74ab4cfe7c9077701814d0799505535c)  
  
NOTE: This project is just a simple implementation for demonstrating sending and listening data through blockchain. The smart contract is NOT complete nor secure, still needs LOTS of adjustments and improvements.
## Concept

Conventional methods of IoT data transmission requires a centralized server (Apple's Home App, Google Home App...). Though they could be considered quite secure, they're still vulnerable to single point of failure (the point where the authentication is checked and where instructions from the external client are accepted). 
  
In blockchain method of IoT data transmission, users send and store data in blockchain smart contract, which is practically impossibile to modify without user's public and private key. IoT devices then listen/subscribe to any state-changed events on blockchain, which doesn't require any open ports to the outside world.

## Quick Start with Truffle

Run listener/subscriber in one terminal:
~~~bash
$ cd Listener && npm install
$ node listener.js
0x1
~~~

Deploy smart contract on Truffle in another terminal:
~~~bash
$ cd IoTSecureManager && npm install
$ truffle develope
truffle(develop)> compile
truffle(develop)> migrate --reset
~~~

Add device and change state:
~~~bash
truffle(develop)> app = await IoTSecureManager.deployed()
truffle(develop)> accounts = await web3.eth.getAccounts()
truffle(develop)> app.setInstructions(accounts[0], 'light1', 'on')
truffle(develop)> app.getInstructions(accounts[0], 'light1')
truffle(develop)> app.getDevices(accounts[0])
truffle(develop)> app.setState(accounts[0], 'light1', 'on')
truffle(develop)> app.getState(accounts[0], 'light1')
~~~

You should receive something similar in the listener/subscriber terminal:
~~~bash
transaction hash:  0x8fa50477a2540d6872eaf082750f0e420fb6bc2531c1abd332c7884c8d1cbeb7
sent from address:  0xAD6cfC0234273D064A8FA6040E16C0bE5428e5dA
device:  light
state:  on
~~~


## Encryption
Though this method of IoT data transmission prevents data being modified from unauthorized individuals, user's device state is public to the world, meaning that the anyone would know if a user's living room light is on or off. To deal with this privacy issue, users are encouraged to encrypt data before sending and decrypt it after receiving on local machines to prevent others from knowing the used encryption method.

## IoTSecureManager/ 
The smart contract file is contracts/IoTSecureManager.sol in IotSecureManager directory.

## Listener/
Main files are abi.json & listener.js in Listener directory, the rest are just npm packages.  
NOTE: abi.json file needs to be updated if any changes are made to IoTSecureManager.sol, just replace with the abi part of the content in IoTSecureManager/build/contracts/IoTSecureManager.json after new compile of the modified IoTSecureManager.sol .

## Reference
1. Securely Controlling Hardware Devices with Blockchain: https://medium.com/coreledger/securely-controlling-hardware-devices-with-blockchain-642af4308529
2. Solidity Event: https://docs.soliditylang.org/en/v0.4.24/contracts.html#events
3. Web3 Event Listener: https://web3js.readthedocs.io/en/v1.2.11/web3-eth-contract.html#contract-events
