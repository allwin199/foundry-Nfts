// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console2} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract MintBasicNft is Script {
    string public constant TOKEN_URI = "ipfs://bafybeietajviz34cqtxjuv74orhpakbi2th5qok5qscym4a5srskverxua/";

    function run() external {
        address mostRecentlyDepolyed = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);

        mintNftOnContract(mostRecentlyDepolyed);
    }

    function mintNftOnContract(address _contractAddress) public {
        BasicNft basicNft = BasicNft(_contractAddress);

        vm.startBroadcast();
        basicNft.mintNft(TOKEN_URI);
        vm.stopBroadcast();

        console2.log("NFT minted successfully!");
    }
}
