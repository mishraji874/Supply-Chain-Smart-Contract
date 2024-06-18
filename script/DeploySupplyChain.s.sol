// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {SupplyChain} from "../src/SupplyChain.sol";

contract DeploySupplyChain is Script {
    function run() external returns (SupplyChain) {
        vm.startBroadcast();
        SupplyChain supplyChain = new SupplyChain();
        console.log("SupplyChain Contract is deployed at: ", address(supplyChain));
        vm.stopBroadcast();
        return supplyChain;
    }
}