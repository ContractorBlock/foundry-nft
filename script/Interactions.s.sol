// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract InteractionsMintBasicNft is Script {
    string public constant PUG_URI =
        "ipfs://QmYdD4NWtd8cYRbos82HhKJFnuJEEdLGuQNELt41HxQsxT?filename=NFTmetadata.json";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNFT",
            block.chainid
        );
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNFT(contractAddress).mintNft(PUG_URI);
        vm.stopBroadcast();
    }
}
