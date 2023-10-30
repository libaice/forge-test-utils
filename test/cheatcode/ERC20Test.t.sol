//SPDX-Lincense-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../src/mock/MockERC20.sol";
import "../../src/SignUtils.sol";
import "forge-std/console.sol";

contract ERC20Test is Test {
    MockERC20 internal token;
    SignUtils internal signUtils;

    uint256 internal ownerPrivateKey;
    uint256 internal spenderPrivateKey;

    address internal owner;
    address internal spender;

    function setUp() public {
        token = new MockERC20();
        signUtils = new SignUtils(token.DOMAIN_SEPARATOR());
        ownerPrivateKey = 0xA11CE;
        spenderPrivateKey = 0xB0b;

        owner = vm.addr(ownerPrivateKey);
        spender = vm.addr(spenderPrivateKey);

        token.mint(owner, 1e18);
    }

    function test_Permit() public {
        SignUtils.Permit memory permit = SignUtils.Permit({
            owner: owner,
            spender: spender,
            value: 1e18,
            nonce: 0,
            deadline: 1 days
        });

        bytes32 digest = signUtils.getTypedDataHash(permit);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(ownerPrivateKey, digest);

        token.permit(
            permit.owner,
            permit.spender,
            permit.value,
            permit.deadline,
            v,
            r,
            s
        );  

        console.log(token.allowance(owner, spender));
        console.log(token.nonces(owner));

        assertEq(token.allowance(owner, spender), 1e18);
        assertEq(token.nonces(owner), 1);
    }
}
