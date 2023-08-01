// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console2} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract BasicNftTest is Test {
    BasicNft basicNft;

    address public USER = makeAddr("user");
    string public constant TOKEN_URI =
        "ipfs://bafybeietajviz34cqtxjuv74orhpakbi2th5qok5qscym4a5srskverxua/";

    function setUp() external {
        DeployBasicNft deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function test_NameIsCorrect() public {
        // Arrange
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();

        // Act / Assert
        assertEq(actualName, expectedName, "nftName");

        /// @dev strings are basically dynamic arrays
        /// If we do assert(actualName == expectedName)
        /// It is not comparable
        /// becuase arrays are not primitive type
        /// To compate 2 arrays, we have to abi encode them to get the hashes
        /// because hashes are fixed length
        /// strings has be converted to bytes, then bytes has to be converted to bytes32
        /// now bytes32 will contain hash of the strings
        /// since hashes are of same length, we can compare both the hashes

        // assert(
        //     keccak256(abi.encodePacked(actualName)) ==
        //         keccak256(abi.encodePacked(expectedName))
        // );
    }

    function test_CanMintAndHaveBalance() public {
        // Arrange
        vm.prank(USER);

        // Act
        basicNft.mintNft(TOKEN_URI);

        // Assert
        assertEq(basicNft.balanceOf(USER), 1, "ownerBalance");
    }

    function test_TokenUriSetCorrectly() public {
        // Arrange
        vm.prank(USER);

        // Act
        basicNft.mintNft(TOKEN_URI);

        // Assert
        assertEq(basicNft.tokenURI(0), TOKEN_URI, "tokenUri");
        // assert(
        //     keccak256(abi.encodePacked(basicNft.tokenURI(0))) ==
        //         keccak256(abi.encodePacked(TOKEN_URI))
        // );
    }
}
