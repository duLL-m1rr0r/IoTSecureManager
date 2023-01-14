const IoTSecureManager = artifacts.require('IoTSecureManager');

module.exports = function(deployer){
    deployer.deploy(IoTSecureManager);
}