// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IoTSecureManager{
    struct Device{
        string[] instructions;
        string state;
    }
    mapping(address => string[]) iotDevices; 
    mapping(address =>  mapping(string => Device)) iotDeviceInstructions;
    event ChangeState(address _a, string deviceName, string state);

    function getDevices(address _a) external view returns (string[] memory){
        return iotDevices[_a];
    }
    function getInstructions(address _a, string calldata deviceName) external view returns (string[] memory){
        return iotDeviceInstructions[_a][deviceName].instructions;
    }
    function getState(address _a, string calldata deviceName) external view returns (string memory){
        return iotDeviceInstructions[_a][deviceName].state;
    }
    function setDevices(address _a, string calldata deviceName) private{
        iotDevices[_a].push(deviceName);
    }
    function setInstructions(address _a, string calldata deviceName, string calldata instructions) public{
        iotDeviceInstructions[_a][deviceName].instructions.push(instructions);

        for (uint8 i = 0; i < iotDevices[_a].length; i++) //check if device already exists
            if (keccak256(bytes(iotDevices[_a][i])) == keccak256(bytes(deviceName))) 
                return;
        setDevices(_a, deviceName);
    }
    function setState(address _a, string calldata deviceName, string calldata state) public{
        iotDeviceInstructions[_a][deviceName].state = state;
        emit ChangeState(_a, deviceName, state);
    }
}