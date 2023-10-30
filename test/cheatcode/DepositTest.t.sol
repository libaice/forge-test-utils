// //SPDX-Lincense-Identifier: MIT
// pragma solidity ^0.8.13;
// import "forge-std/Test.sol";

// import "../../src/Deposit.sol";
// import "../../src/mock/MockERC20.sol";
// import "../../src/SignUtils.sol";

// contract DepositTest is Test {
//     Deposit internal deposit;
//     MockERC20 internal token;
//     SignUtils internal signUtils;

//     uint256 internal ownerPrivateKey;
//     address internal owner;

//     function setUp() public {
//         deposit = new Deposit();
//         token = new MockERC20();
//         signUtils = new SignUtils(token.DOMAIN_SEPARATOR());

//         ownerPrivateKey = 0xA11CE;
//         owner = vm.addr(ownerPrivateKey);
//         token.mint(owner, 1e18);
//     }

//     function test_DepositWithLimitedPermit() public {
//         SignUtils.Permit memory permit = SignUtils.Permit({
//             owner: owner,
//             spender: address(deposit),
//             value: 1e18,
//             nonce: token.nonces(owner),
//             deadline: 1 days
//         });

//         bytes32 digest = signUtils.getTypedDataHash(permit);

//         (uint8 v, bytes32 r, bytes32 s) = vm.sign(ownerPrivateKey, digest);

//         deposit.depositWithPermit(
//             address(token),
//             1e18,
//             permit.owner,
//             permit.spender,
//             permit.value,
//             permit.deadline,
//             v,
//             r,
//             s
//         );

//         assertEq(token.balanceOf(owner), 0);
//         assertEq(token.balanceOf(address(deposit)), 1e18);

//         assertEq(token.allowance(owner, address(deposit)), 0);
//         assertEq(token.nonces(owner), 1);

//         assertEq(deposit.userDeposits(owner, address(token)), 1e18);
//     }

//     function test_DepositWithMaxPermit() public {
//         SignUtils.Permit memory permit = SignUtils.Permit({
//             owner: owner,
//             spender: address(deposit),
//             value: type(uint256).max,
//             nonce: token.nonces(owner),
//             deadline: 1 days
//         });

//         bytes32 digest = signUtils.getTypedDataHash(permit);

//         (uint8 v, bytes32 r, bytes32 s) = vm.sign(ownerPrivateKey, digest);

//         deposit.depositWithPermit(
//             address(token),
//             1e18,
//             permit.owner,
//             permit.spender,
//             permit.value,
//             permit.deadline,
//             v,
//             r,
//             s
//         );

//         assertEq(token.balanceOf(owner), 0);
//         assertEq(token.balanceOf(address(deposit)), 1e18);

//         assertEq(token.allowance(owner, address(deposit)), type(uint256).max);
//         assertEq(token.nonces(owner), 1);

//         assertEq(deposit.userDeposits(owner, address(token)), 1e18);
//     }
// }
