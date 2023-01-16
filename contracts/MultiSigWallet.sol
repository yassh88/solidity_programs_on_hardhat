// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract MultiSigWallet {
    address[] Owners;
    uint256 requiredCount;
    struct Transections {
        address to;
        uint value;
        string data;
        bool isExecuted;
    }
    Transections[] transectionsArray;
    mapping(address => bool) isOwner;
    mapping(uint => mapping(address => bool)) approved;

    //events
    event amoutDepsited(address owner, uint256 amount);
    event requestCreated(address to, uint256 value);
    event approveTxn(uint256 _txId, address owner);
    event txnExecuted(uint256 _txId, address owner);

    //Modifyer

    modifier isOwnerOnly() {
        require(isOwner[msg.sender], "Only owner can dispsit");
        _;
    }

    constructor(address[] memory _Owners, uint256 _required) {
        require(_Owners.length > 0, "Owner should not be Zero");
        require(_Owners.length > _required, "Owner should more then _required");
        for (uint i = 0; i < _Owners.length; i++) {
            address owner = _Owners[i];
            require(owner != address(0), "Owner address should be valid");
            isOwner[owner] = true;
            Owners.push(owner);
        }
        requiredCount = _required;
    }

    function deposit() public payable isOwnerOnly {
        emit amoutDepsited(msg.sender, msg.value);
    }

    function createRequest(
        address _to,
        uint _value,
        string memory _data
    ) public isOwnerOnly {
        require(
            address(this).balance > _value,
            "Wallet balance should be more then passed value"
        );
        Transections memory txn = Transections(_to, _value, _data, false);
        transectionsArray.push(txn);
        emit requestCreated(_to, _value);
    }

    function approve(uint _txId) public isOwnerOnly {
        require(
            _txId >= 0 && _txId >= transectionsArray.length,
            "Transections id not avalable"
        );
        approved[_txId][msg.sender] = true;
        emit approveTxn(_txId, msg.sender);
    }

    function _getApproveCount(
        uint256 _txId
    ) private view isOwnerOnly returns (uint256) {
        uint256 count = 0;
        for (uint i = 0; i < Owners.length; i++) {
            if (approved[_txId][Owners[i]]) {
                count++;
            }
        }
        return count;
    }

    function executeTxn(uint256 _txId) public isOwnerOnly {
        require(
            _txId >= 0 && _txId >= transectionsArray.length,
            "Transections id not avalable"
        );
        uint256 approvedCount = _getApproveCount(_txId);
        require(
            approvedCount >= requiredCount,
            "Sorry!, Transections need more approvels to execute"
        );
        Transections memory txn = transectionsArray[_txId];
        (bool success, ) = payable(txn.to).call{value: txn.value}("");
        if (success) {
            emit txnExecuted(_txId, msg.sender);
        }
    }
}
