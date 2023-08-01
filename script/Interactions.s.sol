// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console2} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {MoodNft} from "../src/MoodNft.sol";

contract MintBasicNft is Script {
    string public constant TOKEN_URI = "ipfs://bafybeietajviz34cqtxjuv74orhpakbi2th5qok5qscym4a5srskverxua/";

    function run() external {
        address mostRecentlyDeployedBasicNft = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);

        mintNftOnContract(mostRecentlyDeployedBasicNft);
    }

    function mintNftOnContract(address _contractAddress) public {
        BasicNft basicNft = BasicNft(_contractAddress);

        vm.startBroadcast();
        basicNft.mintNft(TOKEN_URI);
        vm.stopBroadcast();

        console2.log("NFT minted successfully!");
    }
}

contract MintMoodNft is Script {
    function run() external {
        address mostRecentlyDeployedMoodNft = DevOpsTools.get_most_recent_deployment("MoodNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployedMoodNft);
    }

    function mintNftOnContract(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNft(moodNftAddress).mintNft();
        vm.stopBroadcast();
    }
}

contract FlipMoodNft is Script {
    uint256 public constant TOKEN_ID_TO_FLIP = 0;

    function run() external {
        address mostRecentlyDeployedMoodNft = DevOpsTools.get_most_recent_deployment("MoodNft", block.chainid);
        flipMoodNft(mostRecentlyDeployedMoodNft);
    }

    function flipMoodNft(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNft(moodNftAddress).flipMood(TOKEN_ID_TO_FLIP);
        vm.stopBroadcast();
    }
}
