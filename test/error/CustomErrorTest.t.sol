//SPDX-Lincense-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../src/RevertCustomError.sol";

contract CustomErrorTest is Test{
    CustomErrorContract public customErrorContract;
    error SomeError(uint256);

    function setUp() public {
        customErrorContract = new CustomErrorContract();
    }

    function testRevert()public{
        vm.expectRevert(abi.encodeWithSelector(SomeError.selector, 5) );
        customErrorContract.revertError(5);
    }
}