var Contract = require('web3-eth-contract');
var abi = require("./abi.json");
var contractAddress = "0x772F00599e7BF6070d89F417Bf1053Eda282b265"
Contract.setProvider('ws://127.0.0.1:9545/'); 
var contract = new Contract(abi, contractAddress);

contract.events.ChangeState()
   .on("connected", function(subscriptionId){ console.log(subscriptionId);})
   .on('data', function(event){
      console.log('transaction hash: ', event.transactionHash) 
      let returnValues = event.returnValues
      console.log('sent from address: ', returnValues._a);
      console.log('device: ', returnValues.deviceName);
      console.log('state: ', returnValues.state);
   })