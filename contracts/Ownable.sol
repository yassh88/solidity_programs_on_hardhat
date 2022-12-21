// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Ownable {
    address owner;

    event ownerChnaged(address indexed newOwner, address indexed oldOwner);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert("Only owner can do this");
        }
        _;
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function changeOwnership(address _newOwner) public onlyOwner {
        if (_newOwner == address(0)) {
            revert("new Owner address in not corract");
        }
        owner = _newOwner;
        emit ownerChnaged(_newOwner, msg.sender);
    }

    function renounceOwnership() public virtual onlyOwner {
        owner = address(0);
    }
}
