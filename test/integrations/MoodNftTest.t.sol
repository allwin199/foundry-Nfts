// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console2} from "forge-std/Test.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";
import {MoodNft} from "../../src/MoodNft.sol";

contract MoodNftTest is Test {
    string constant NFT_NAME = "Mood NFT";
    string constant NFT_SYMBOL = "MN";
    MoodNft moodNft;

    address public USER = makeAddr("user");

    string public constant HAPPY_MOOD_URI =
        "data:application/json;base64,eyJuYW1lIjoiTW9vZCBORlQiLCAiZGVzY3JpcHRpb24iOiJBbiBORlQgdGhhdCByZWZsZWN0cyB0aGUgbW9vZCBvZiB0aGUgb3duZXIsIDEwMCUgb24gQ2hhaW4hIiwgImF0dHJpYnV0ZXMiOiBbeyJ0cmFpdF90eXBlIjogIm1vb2RpbmVzcyIsICJ2YWx1ZSI6IDEwMH1dLCAiaW1hZ2UiOiJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUIyYVdWM1FtOTRQU0l3SURBZ01qQXdJREl3TUNJZ2QybGtkR2c5SWpRd01DSWdJR2hsYVdkb2REMGlOREF3SWlCNGJXeHVjejBpYUhSMGNEb3ZMM2QzZHk1M015NXZjbWN2TWpBd01DOXpkbWNpUGdvZ0lEeGphWEpqYkdVZ1kzZzlJakV3TUNJZ1kzazlJakV3TUNJZ1ptbHNiRDBpZVdWc2JHOTNJaUJ5UFNJM09DSWdjM1J5YjJ0bFBTSmliR0ZqYXlJZ2MzUnliMnRsTFhkcFpIUm9QU0l6SWk4K0NpQWdQR2NnWTJ4aGMzTTlJbVY1WlhNaVBnb2dJQ0FnUEdOcGNtTnNaU0JqZUQwaU5qRWlJR041UFNJNE1pSWdjajBpTVRJaUx6NEtJQ0FnSUR4amFYSmpiR1VnWTNnOUlqRXlOeUlnWTNrOUlqZ3lJaUJ5UFNJeE1pSXZQZ29nSUR3dlp6NEtJQ0E4Y0dGMGFDQmtQU0p0TVRNMkxqZ3hJREV4Tmk0MU0yTXVOamtnTWpZdU1UY3ROalF1TVRFZ05ESXRPREV1TlRJdExqY3pJaUJ6ZEhsc1pUMGlabWxzYkRwdWIyNWxPeUJ6ZEhKdmEyVTZJR0pzWVdOck95QnpkSEp2YTJVdGQybGtkR2c2SURNN0lpOCtDand2YzNablBnPT0ifQ==";

    string public constant SAD_MOOD_URI =
        "data:application/json;base64,eyJuYW1lIjoiTW9vZCBORlQiLCAiZGVzY3JpcHRpb24iOiJBbiBORlQgdGhhdCByZWZsZWN0cyB0aGUgbW9vZCBvZiB0aGUgb3duZXIsIDEwMCUgb24gQ2hhaW4hIiwgImF0dHJpYnV0ZXMiOiBbeyJ0cmFpdF90eXBlIjogIm1vb2RpbmVzcyIsICJ2YWx1ZSI6IDEwMH1dLCAiaW1hZ2UiOiJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUIyYVdWM1FtOTRQU0l3SURBZ01qQXdJREl3TUNJZ2QybGtkR2c5SWpRd01DSWdJR2hsYVdkb2REMGlOREF3SWlCNGJXeHVjejBpYUhSMGNEb3ZMM2QzZHk1M015NXZjbWN2TWpBd01DOXpkbWNpUGdvZ0lEeGphWEpqYkdVZ1kzZzlJakV3TUNJZ1kzazlJakV3TUNJZ1ptbHNiRDBpZVdWc2JHOTNJaUJ5UFNJM09DSWdjM1J5YjJ0bFBTSmliR0ZqYXlJZ2MzUnliMnRsTFhkcFpIUm9QU0l6SWk4K0NpQWdQR2NnWTJ4aGMzTTlJbVY1WlhNaVBnb2dJQ0FnUEdOcGNtTnNaU0JqZUQwaU5qRWlJR041UFNJNE1pSWdjajBpTVRJaUx6NEtJQ0FnSUR4amFYSmpiR1VnWTNnOUlqRXlOeUlnWTNrOUlqZ3lJaUJ5UFNJeE1pSXZQZ29nSUR3dlp6NEtJQ0E4Y0dGMGFDQmtQU0p0TVRNMkxqZ3hJREUwTUM0MU0yTXVOamtnTFRJMkxqRTNMVFkwTGpFeElDMDBOUzA0TVM0MU1pMHVOek1pSUhOMGVXeGxQU0ptYVd4c09tNXZibVU3SUhOMGNtOXJaVG9nWW14aFkyczdJSE4wY205clpTMTNhV1IwYURvZ016c2lMejRLUEM5emRtYysifQ==";

    function setUp() public {
        DeployMoodNft deployer = new DeployMoodNft();
        moodNft = deployer.run();
    }

    function test_NameIsSetCorrectly() public {
        assertEq(moodNft.name(), NFT_NAME);
    }

    function test_SymbolIsSetCorrectly() public {
        assertEq(moodNft.symbol(), NFT_SYMBOL);
    }

    function test_CanMintAndHaveABalance() public {
        vm.prank(USER);
        moodNft.mintNft();

        assertEq(moodNft.balanceOf(USER), 1);
    }

    function test_TokenUriIsPopulated() public {
        vm.prank(USER);
        moodNft.mintNft();
        string memory tokenUri = moodNft.tokenURI(0);

        assertEq(tokenUri, HAPPY_MOOD_URI);
        // assert(
        //     keccak256(abi.encodePacked(moodNft.tokenURI(0))) ==
        //         keccak256(abi.encodePacked(HAPPY_MOOD_URI))
        // );
    }

    function test_FlipMood_RevertsIfNotCalledByOwner() public {
        vm.prank(USER);
        moodNft.mintNft();

        vm.expectRevert(MoodNft.MoodNft__CantFlipMoodIfNotOwner.selector);
        moodNft.flipMood(0);
    }

    function test_FlipMood_WorksCorrectly() public {
        vm.startPrank(USER);
        moodNft.mintNft();

        moodNft.flipMood(0);
        MoodNft.NFTState prevNftState = moodNft.getCurrentMood(0);
        moodNft.flipMood(0);
        MoodNft.NFTState currentNftState = moodNft.getCurrentMood(0);
        moodNft.flipMood(0);
        vm.stopPrank();

        assertEq(uint256(prevNftState), uint256(MoodNft.NFTState.SAD));
        assertEq(uint256(currentNftState), uint256(MoodNft.NFTState.HAPPY));

        string memory tokenUri = moodNft.tokenURI(0);
        assertEq(tokenUri, SAD_MOOD_URI);
    }
}
