// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract PiggyBank {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    event amountAdded(uint256 amount);
    event amountWithdraw(uint256 amount);

    modifier onlyOwner() {
        if (owner != msg.sender) {
            revert("PiggyBank_onlyOwnerCanDO");
        }
        _;
    }

    function diposit() public payable {
        emit amountAdded(msg.value);
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function withdraw() public onlyOwner {
        emit amountWithdraw(address(this).balance);
        selfdestruct(payable(msg.sender));
    }
}
