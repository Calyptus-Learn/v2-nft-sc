// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {CalyptusNFTTest} from "./CalyptusNFT.t.sol";
import "./Utils.sol";

contract TestSafeMint is CalyptusNFTTest {
    function testSafeMintToCalyptusInternalAddress() public {
        _safeMintToCalyptusInternalWallet();
        assertEq(calyptusNFT.balanceOf(calyptusInternalAddress), 1);
    }

    function testSafeMintToExternalWallet(address to) public {
        _addressFuzzChecks(to);
        _safeMintToExternalWallet(to);
        assertEq(calyptusNFT.balanceOf(to), 1);
    }

    function testShouldRevertIfNonOwnerCallsSafeMint(address to) public {
        _addressFuzzChecks(to);
        string memory uri = Utils.addressToString(to);
        vm.startPrank(to);
        vm.expectRevert(abi.encodeWithSignature("OwnableUnauthorizedAccount(address)", to));
        calyptusNFT.safeMint(to, uri);
        vm.stopPrank();
    }
}
