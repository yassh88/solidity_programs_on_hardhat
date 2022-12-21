// SPDX-License-Identifier: SEE LICENSE IN LICENSE

pragma solidity ^0.8.17;

contract Todo {
    address owner;
    uint private taskNo = 0;
    mapping(uint256 => string) tasks;
    mapping(uint256 => bool) competedTask;
    event taskAdded(string indexed task);
    event competed(string indexed task);

    constructor() {
        owner = msg.sender;
    }

    modifier isOwner() {
        if (msg.sender != owner) {
            revert("Todo_OnlyOwnerCanDO");
        }
        _;
    }

    function addTask(string memory _task) public isOwner {
        tasks[taskNo] = _task;
        competedTask[taskNo] = false;
        taskNo += 1;
    }

    function taskCompelted(uint256 _index) public isOwner {
        competedTask[_index] = true;
    }

    function getTask(uint256 _index) public view returns (string memory) {
        return tasks[_index];
    }

    function isTaskCompleted(uint256 _index) public view returns (bool) {
        return competedTask[_index];
    }
}
