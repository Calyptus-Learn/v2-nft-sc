// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "../src/CalyptusNFT.sol";
import "forge-std/Test.sol";
import "./Utils.sol";

contract CalyptusNFTTest is Test {
    CalyptusNFT public calyptusNFT;
    address public calyptusInternalAddress = address(0xdad);

    /// @dev Setting up the testing environment
    function setUp() public {
        calyptusNFT = new CalyptusNFT();
        calyptusNFT.initialize(calyptusInternalAddress);
    }

    /// @dev testing initial values on deployment
    function testInitialValues() public {
        assertEq(calyptusNFT.owner(), calyptusInternalAddress);
    }

    /////////////////////////////////////
    // Internal Functions
    /////////////////////////////////////

    function _safeMintToExternalWallet(address to) internal returns (uint256 tokenId) {
        string memory uri = Utils.addressToString(to);
        vm.startPrank(calyptusInternalAddress);
        tokenId = calyptusNFT.nextTokenId();
        calyptusNFT.safeMint(to, uri);
        vm.stopPrank();
    }

    function _safeMintToCalyptusInternalWallet() internal returns (uint256 tokenId) {
        string memory uri = Utils.addressToString(calyptusInternalAddress);
        vm.startPrank(calyptusInternalAddress);
        tokenId = calyptusNFT.nextTokenId();
        calyptusNFT.safeMint(calyptusInternalAddress, uri);
        vm.stopPrank();
    }

    function _addressFuzzChecks(address addr) internal view {
        vm.assume(addr != address(0));
        // Ask fuzzer to assume that the one claiming the nft is an EOA
        // To avoid test fail due to ERC721Receiver
        uint32 size;
        assembly {
            size := extcodesize(addr)
        }
        vm.assume(size == 0);

        vm.assume(addr != calyptusInternalAddress);
    }
}
