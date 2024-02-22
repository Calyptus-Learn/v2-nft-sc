// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {CalyptusNFTTest} from "./CalyptusNFT.t.sol";
import {Utils} from "./Utils.sol";

contract TestUpdateURI is CalyptusNFTTest {
    function testUpdateURIOnCalyptusInternalWallet() public {
        uint256 tokenId = _safeMintToCalyptusInternalWallet();
        string memory oldUri = Utils.addressToString(calyptusInternalAddress);
        string memory newUri = "https://example.com";

        assertEq(calyptusNFT.tokenURI(tokenId), oldUri);

        vm.startPrank(calyptusInternalAddress);
        calyptusNFT.updateURI(tokenId, newUri);
        vm.stopPrank();

        assertEq(calyptusNFT.tokenURI(tokenId), newUri);
    }

    function testUpdateURIOnExternalWallet(address to) public {
        _addressFuzzChecks(to);
        uint256 tokenId = _safeMintToExternalWallet(to);
        string memory oldUri = Utils.addressToString(to);
        string memory newUri = "https://example.com";

        assertEq(calyptusNFT.tokenURI(tokenId), oldUri);

        vm.startPrank(calyptusInternalAddress);
        calyptusNFT.updateURI(tokenId, newUri);
        vm.stopPrank();

        assertEq(calyptusNFT.tokenURI(tokenId), newUri);
    }

    function testShouldFailOnNonCalyptusAccountUpdateURI(address to) public {
        _addressFuzzChecks(to);
        uint256 tokenId = _safeMintToExternalWallet(to);
        string memory oldUri = Utils.addressToString(to);
        string memory newUri = "https://example.com";

        assertEq(calyptusNFT.tokenURI(tokenId), oldUri);

        vm.startPrank(to);
        vm.expectRevert(abi.encodeWithSignature("OwnableUnauthorizedAccount(address)", to));
        calyptusNFT.updateURI(tokenId, newUri);
        vm.stopPrank();
    }
}
