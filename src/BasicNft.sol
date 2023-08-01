// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/// @title Basic NFT
/// @author Prince Allwin
/// @notice This contract is creating Dogie NFTs
contract BasicNft is ERC721 {
    /*/////////////////////////////////////////////////////////////////////////////
                                PRIVATE STORAGE
    /////////////////////////////////////////////////////////////////////////////*/

    /// @dev tokenCounter will act as the tokenId, it will be initialized in the constructor
    uint256 private s_tokenCounter;

    /// @dev Each "Dogie" NFT will get it's `tokenId`, so everything will be unique
    /// @dev unique nft is based on the contract address which basically represents the collection
    /// and then the `tokenId`

    /*/////////////////////////////////////////////////////////////////////////////
                                    CONSTRUCTOR
    /////////////////////////////////////////////////////////////////////////////*/

    constructor() ERC721("Dogie", "DOG") {
        s_tokenCounter = 0;
    }

    /*/////////////////////////////////////////////////////////////////////////////
                                Public Functions
    /////////////////////////////////////////////////////////////////////////////*/

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter = s_tokenCounter + 1;
    }

    /// URI - Uniform Resource Identifier
    /// A Uniform Resource Identifier (URI) is a string of characters that identifies a resource on the internet.
    /// URIs are used to identify web pages, files, and other resources.
    /// @dev tokenURI is almost simliar to api endpoint hosted somewhere, it will return the `metadata` for the NFT

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        return "";
    }
}
