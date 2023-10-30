//SPDX-Lincense-Identifier: MIT
pragma solidity ^0.8.13;
import "forge-std/Test.sol";

contract CheatCodeTest is Test {
    function test_Warp() public {
        vm.warp(164107080);
        emit log_uint(block.timestamp);
    }

    function test_Roll() public {
        vm.roll(199);
        emit log_uint(block.number);
    }

    function test_ChainId() public {
        vm.chainId(12);
        emit log_uint(block.chainid);
    }

    function test_Deal() public {
        address alice = makeAddr("alice");
        emit log_address(alice);
        vm.deal(alice, 1 ether);
        // log_uint256(alice.balance);
    }

    function test_Prank() public {
        address alice = makeAddr("alice");
        vm.prank(alice);
        emit log_uint256(alice.balance);
    }
}
