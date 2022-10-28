// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract EncodeData {
    function getData() public view returns(bytes memory data) {
        data = abi.encodeWithSignature("claim()");
    }
}
