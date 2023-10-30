//SPDX-Lincense-Identifier: MIT
pragma solidity ^0.8.13;

import {ERC20} from "solmate/tokens/ERC20.sol";

contract Deposit {
    event TokenDeposit(address user, address tokenContract, uint256 amount);
    event TokenWithdraw(address user, address tokenContract, uint256 amount);
    mapping(address => mapping(address => uint256)) public userDeposits;

    // constructor() ERC20("Mock Tokem", "MockERC20", 18) {}

    function deposit(address _tokenContract, uint256 _amount) external {
        ERC20(_tokenContract).transferFrom(msg.sender, address(this), _amount);
        userDeposits[msg.sender][_tokenContract] += _amount;
        emit TokenDeposit(msg.sender, _tokenContract, _amount);
    }

    function depositWithPermit(
        address _tokenContract,
        uint256 _amount,
        address _owner,
        address _spender,
        uint256 _value,
        uint256 _deadline,
        uint8 _v,
        bytes32 _r,
        bytes32 _s
    ) external {
        ERC20(_tokenContract).permit(
            _owner,
            _spender,
            _value,
            _deadline,
            _v,
            _r,
            _s
        );
        ERC20(_tokenContract).transferFrom(msg.sender, address(this), _amount);
        userDeposits[msg.sender][_tokenContract] += _amount;
        emit TokenDeposit(msg.sender, _tokenContract, _amount);
    }

    function withdraw(address _tokenContract, uint256 _amount) external {
        require(
            userDeposits[msg.sender][_tokenContract] >= _amount,
            "Insufficient balance"
        );
        userDeposits[msg.sender][_tokenContract] -= _amount;
        ERC20(_tokenContract).transfer(msg.sender, _amount);
        emit TokenWithdraw(msg.sender, _tokenContract, _amount);
    }
}
