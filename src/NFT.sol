//SPDX-Lincense-Identifier: MIT
//progma solidity  0.8.10

import "solmate/tokens/ERC721.sol";
// optimized import by using remapping.txt
// import "@openzeppelin/contracts/utils/Strings.sol";
import "openzeppelin-contracts/contracts/utils/Strings.sol";

contract NFT is ERC721 {
    uint256 public currentTokenId;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {}

    function MintTo(address receipt) public payable returns (uint256) {
        uint256 newItemId = ++currentTokenId;
        _safeMint(receipt, newItemId);
        return newItemId;
    }

    function tokenURI(
        uint256 id
    ) public view virtual override returns (string memory) {
        return Strings.toString(id);
    }
}
