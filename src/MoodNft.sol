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
    function mintNft(string memory _tokenUri) public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = NFTState.HAPPY;
        s_tokenCounter = s_tokenCounter + 1;
    }

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        string memory imageURI;

        if (s_tokenIdToMood[_tokenId] == NFTState.HAPPY) {
            imageURI = s_happySvgImageUri;
        } else {
            imageURI = s_sadSvgImageUri;
        }

        bytes memory dataURI = abi.encodePacked(
            '{"name":"',
            name(),
            _tokenId,
            '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
            '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
            imageURI,
            '"}'
        );

        /// @dev we are converting it to bytes to use openzeppelin base64 encoder

        return string(abi.encodePacked("data:application/json;base64,", Base64.encode(dataURI)));

        /// @dev refer https://docs.openzeppelin.com/contracts/4.x/utilities#base64
    }
}
