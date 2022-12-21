// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract myNFT is ERC721 {
    uint256 minited = 0;
    uint256 totalSupply = 100;
    uint256 tokenId = 1;
    uint256 rate = .01 ether;

    constructor() ERC721("Yashwant", "YR") {
        _mint(msg.sender, tokenId++);
    }

    function mint() public payable {
        if (minited + 1 > totalSupply) {
            revert("All supply done");
        }
        if (msg.value < rate) {
            revert("Sent amout is less then rate");
        }
        _mint(msg.sender, tokenId++);
        minited += 1;
    }

    receive() external payable {}
}
