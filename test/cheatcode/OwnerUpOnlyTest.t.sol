//SPDX-Lincense-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";

error Unauthorized();

contract OwnerUpOnly {
    address public immutable owner;
    uint256 public count;

    constructor() {
        owner = msg.sender;
    }

    function increment() external {
        if (msg.sender != owner) {
            revert Unauthorized();
        }
        count++;
    }
}

contract OwnerUpOnlyTest is Test {
    OwnerUpOnly public upOnly;

    function setUp() public {
        upOnly = new OwnerUpOnly();
    }

    function testIncrement() public {
        assertEq(upOnly.count(), 0);
        console.log("before count: %s", upOnly.count());
        upOnly.increment();
        console.log("after count: %s", upOnly.count());
        assertEq(upOnly.count(), 1);
    }
}
