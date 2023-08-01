// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Test, console2} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract DeployBasicNftTest is Test {
    DeployBasicNft deployer;
    BasicNft basicNft;

    function setUp() public {
        deployer = new DeployBasicNft();
    }

    function test_DeployBasicNft() public {
        basicNft = deployer.run();
        assertTrue(address(basicNft) != address(0), "deployBasicNft");
    }
}
