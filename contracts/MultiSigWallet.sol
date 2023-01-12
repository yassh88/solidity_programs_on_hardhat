// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract MultiSigWallet {
    address[] Owners;
    uint256 required;
    struct Transections {
        address to;
        uint value;
        string data;
        bool isExecuted;
    }
    mapping(address => bool) isOwner;

    constructor(address[] memory _Owners, uint256 _required) {
        require(_Owners.length > 0, "Owner should not be Zero");
        require(_Owners.length > _required, "Owner should more then _required");
        for (uint i = 0; i < _Owners.length; i++) {
            address owner = _Owners[i];
            require(owner != address(0), "Owner address should be valid");
            isOwner[owner] = true;
            Owners.push(owner);
        }
        required = _required;
    }
}
