// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MoodNft is ERC721 {
    /*/////////////////////////////////////////////////////////////////////////////
                                PRIVATE STORAGE
    /////////////////////////////////////////////////////////////////////////////*/
    /// @dev tokenCounter will act as the tokenId, it will be initialized in the constructor
    uint256 private s_tokenCounter;

    /// @dev Each "Mood" NFT will get it's `tokenId`, so everything will be unique
    /// @dev unique nft is based on the contract address which basically represents the collection
    /// and then the `tokenId`

    mapping(uint256 tokenId => string tokenUri) private s_tokenIdToUri;

    string private s_happySvg;
    string private s_sadSvg;

    /*/////////////////////////////////////////////////////////////////////////////
                                    CONSTRUCTOR
    /////////////////////////////////////////////////////////////////////////////*/
    constructor(
        string memory _happySvg,
        string memory _sadSvg
    ) ERC721("Mood NFT", "MN") {
        s_tokenCounter = 0;
        s_happySvg = _happySvg;
        s_sadSvg = _sadSvg;
    }

    /*/////////////////////////////////////////////////////////////////////////////
                                Public Functions
    /////////////////////////////////////////////////////////////////////////////*/
    function mintNft(string memory _tokenUri) public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter = s_tokenCounter + 1;
    }

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        return s_tokenIdToUri[_tokenId];
    }
}
