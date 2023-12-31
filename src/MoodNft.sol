// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    /*/////////////////////////////////////////////////////////////////////////////
                                TYPE DECLARATIONS
    /////////////////////////////////////////////////////////////////////////////*/
    enum NFTState {
        HAPPY,
        SAD
    }

    /*/////////////////////////////////////////////////////////////////////////////
                                PRIVATE STORAGE
    /////////////////////////////////////////////////////////////////////////////*/
    /// @dev tokenCounter will act as the tokenId, it will be initialized in the constructor
    uint256 private s_tokenCounter;

    /// @dev Each "Mood" NFT will get it's `tokenId`, so everything will be unique
    /// @dev unique nft is based on the contract address which basically represents the collection
    /// and then the `tokenId`

    mapping(uint256 tokenId => NFTState) private s_tokenIdToMood;

    string private s_happySvgImageUri;
    string private s_sadSvgImageUri;

    /*/////////////////////////////////////////////////////////////////////////////
                                CUSTOM ERRORS
    /////////////////////////////////////////////////////////////////////////////*/
    error MoodNft__CantFlipMoodIfNotOwner();

    /*/////////////////////////////////////////////////////////////////////////////
                                    CONSTRUCTOR
    /////////////////////////////////////////////////////////////////////////////*/
    constructor(string memory _happySvgImageUri, string memory _sadSvgImageUri) ERC721("Mood NFT", "MN") {
        s_tokenCounter = 0;
        s_happySvgImageUri = _happySvgImageUri;
        s_sadSvgImageUri = _sadSvgImageUri;
    }

    /*/////////////////////////////////////////////////////////////////////////////
                                Public Functions
    /////////////////////////////////////////////////////////////////////////////*/
    /// @dev mood is deffault to Happy
    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = NFTState.HAPPY;
        s_tokenCounter = s_tokenCounter + 1;
    }

    /// @dev only the NFT owner can change the mood
    function flipMood(uint256 _tokenId) public {
        if (!_isApprovedOrOwner(msg.sender, _tokenId)) {
            revert MoodNft__CantFlipMoodIfNotOwner();
        }
        if (s_tokenIdToMood[_tokenId] == NFTState.HAPPY) {
            s_tokenIdToMood[_tokenId] = NFTState.SAD;
        } else {
            s_tokenIdToMood[_tokenId] = NFTState.HAPPY;
        }
    }

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        string memory imageURI;

        if (s_tokenIdToMood[_tokenId] == NFTState.HAPPY) {
            imageURI = s_happySvgImageUri;
        } else {
            imageURI = s_sadSvgImageUri;
        }

        string memory baseURI = "data:application/json;base64,";

        bytes memory dataURI = abi.encodePacked(
            '{"name":"',
            name(),
            '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
            '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
            imageURI,
            '"}'
        );

        /// @dev we are converting it to bytes to use openzeppelin base64 encoder

        return string(abi.encodePacked(baseURI, Base64.encode(dataURI)));

        /// @dev refer https://docs.openzeppelin.com/contracts/4.x/utilities#base64
    }

    function getCurrentMood(uint256 _tokenId) public view returns (NFTState) {
        return s_tokenIdToMood[_tokenId];
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }
}
