// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {ERC721Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import {ERC721URIStorageUpgradeable} from
    "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import {ERC721PausableUpgradeable} from
    "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721PausableUpgradeable.sol";
import {Ownable2StepUpgradeable} from "@openzeppelin/contracts-upgradeable/access/Ownable2StepUpgradeable.sol";
import {ERC721BurnableUpgradeable} from
    "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721BurnableUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

/// @title Calyptus NFT Contract
/// @notice This contract is for managing a collection of Calyptus NFTs.
/// @dev Extends ERC721 Non-Fungible Token Standard basic implementation with pausability and upgradability.
contract CalyptusNFT is
    Initializable,
    ERC721Upgradeable,
    ERC721URIStorageUpgradeable,
    ERC721PausableUpgradeable,
    Ownable2StepUpgradeable,
    ERC721BurnableUpgradeable,
    UUPSUpgradeable
{
    uint256 public nextTokenId;

    error CalyptusNFT_TransferNotAllowed();

    /// @dev This is the recommendation from the OZ, uncomment it when deploying.
    /// @dev During the tests, it's better to disable it, because it makes the tests fail
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    /// @notice Initializes the contract with the given initial owner.
    /// @dev Sets up the contract with ERC721 standard, along with ownable and pausable features.
    /// @param initialOwner The address of the initial owner of the contract.
    function initialize(address initialOwner) public initializer {
        __ERC721_init("Calyptus", "");
        __ERC721URIStorage_init();
        __ERC721Pausable_init();
        __Ownable_init(initialOwner);
        __ERC721Burnable_init();
        __UUPSUpgradeable_init();
    }

    /// @notice Pauses all token transfers.
    /// @dev Can only be called by the owner when the contract is not paused.
    function pause() public onlyOwner {
        _pause();
    }

    /// @notice Unpauses all token transfers.
    /// @dev Can only be called by the owner when the contract is paused.
    function unpause() public onlyOwner {
        _unpause();
    }

    /// @notice Mints a new token to the specified address with the provided URI.
    /// @dev Can only be called by the owner.
    /// @param to The address to mint the token to.
    /// @param uri The URI for the token metadata.
    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    /// @notice Updates the token URI of a specified token.
    /// @dev Callable by the owner when the contract is not paused.
    /// @param tokenId The token ID whose URI is being updated.
    /// @param uri The new URI for the token metadata.
    function updateURI(uint256 tokenId, string memory uri) public onlyOwner {
        _setTokenURI(tokenId, uri);
    }

    /// @dev Internal function to authorize upgrades of the contract.
    /// @param newImplementation The address of the new contract implementation.
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}

    /// @dev Overrides the _update function from ERC721PausableUpgradeable for additional transfer logic.
    /// @param to The address to transfer the token to.
    /// @param tokenId The token ID to transfer.
    /// @param auth The address authorized to perform the transfer.
    /// @return The address of the previous owner of the token.
    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721Upgradeable, ERC721PausableUpgradeable)
        whenNotPaused
        returns (address)
    {
        address owner = owner();
        address from = _ownerOf(tokenId);
        // Transfer is allowed only in one of the following cases:
        // - the token is being transferred from Calyptus wallet to user's external wallet
        // - the token is being minted/burned
        if (from != owner && from != address(0) && to != address(0)) {
            revert CalyptusNFT_TransferNotAllowed();
        }

        address previousOwner = super._update(to, tokenId, auth);
        return previousOwner;
    }

    ////////////////////////////////////////////////////////////////////
    // The following functions are overrides required by Solidity. ////
    //////////////////////////////////////////////////////////////////

    /// @dev See {IERC721Metadata-tokenURI}.
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    /// @dev See {IERC165-supportsInterface}.
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
