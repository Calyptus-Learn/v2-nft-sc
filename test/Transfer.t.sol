// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {CalyptusNFTTest} from "./CalyptusNFT.t.sol";

contract TestTransfer is CalyptusNFTTest {
    function testTransferNFTFromCalyptusInternalAddress(address to) public {
        _addressFuzzChecks(to);
        uint256 tokenId = _safeMintToCalyptusInternalWallet();

        vm.startPrank(calyptusInternalAddress);
        calyptusNFT.safeTransferFrom(calyptusInternalAddress, to, tokenId);
        vm.stopPrank();
        assertEq(calyptusNFT.balanceOf(to), 1);
        assertEq(calyptusNFT.balanceOf(calyptusInternalAddress), 0);
    }

    function testShouldFailIfTransferFromExternalWallet(address from, address to) public {
        _addressFuzzChecks(from);
        _addressFuzzChecks(to);
        uint256 tokenId = _safeMintToExternalWallet(from);

        vm.startPrank(from);
        vm.expectRevert(abi.encodeWithSignature("CalyptusNFT_TransferNotAllowed()"));
        calyptusNFT.safeTransferFrom(from, to, tokenId);
        vm.stopPrank();
    }
}
