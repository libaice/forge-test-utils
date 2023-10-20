// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";

contract Keccak256Test is Test {
    function test_Keccak256() public {
        bytes memory input = "hello";
        bytes32 expected = 0x1c8aff950685c2ed4bc3174f3472287b56d9517b9c948127319a09a7a36deac8;
        bytes32 actual = keccak256(input);
        assertEq(actual, expected);
    }
    
}
