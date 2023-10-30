//SPDX-Lincense-Identifier: MIT
pragma solidity ^0.8.13;

import "solmate/tokens/ERC20.sol";


contract MockERC20 is ERC20 {
    constructor() ERC20("Mock Tokem", "MockERC20", 18) {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}
