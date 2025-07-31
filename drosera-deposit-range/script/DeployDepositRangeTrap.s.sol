// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import "forge-std/Script.sol";
import "../contracts/DepositRangeTrap.sol";

contract DeployDepositRangeTrap is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        DepositRangeTrap trap = new DepositRangeTrap(0.01 ether, 1 ether);
        console.log("✅ DepositRangeTrap deployed at:", address(trap));

        vm.stopBroadcast();
    }
}
