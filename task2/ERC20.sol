// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ERC20 代币
contract ERC20 {
    mapping(address => uint256) private _balance;
    mapping(address => mapping(address => uint256)) private _allowances;
    string public _name;
    string public _symbol;
    address public _owner;
    uint256 public _totalSupply;

    // 转账事件
    event Transfer(address indexed from, address indexed to, uint256 value);

    // 授权事件
    event Approve(address indexed from, address indexed spender, uint256 value);

    constructor(string memory name, string memory symbol) {
        _name = name;
        _symbol = symbol;
        _owner = msg.sender;
    }

    // 查询账户余额
    function balanceOf(address account) external view returns (uint256) {
        return _balance[account];
    }

    // 转账
    function transfer(address to, uint256 value) external returns (bool) {
        require(_balance[msg.sender] >= value, "Not sufficient funds");
        _balance[msg.sender] -= value;
        _balance[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    // 授权
    function approve(address spender, uint256 value) external returns (bool) {
        _allowances[msg.sender][spender] = value;
        emit Approve(msg.sender, spender, value);
        return true;
    }

    // 授权之后领取
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool) {
        // 先验证from的余额是否足够
        require(_balance[from] >= value, "Not sufficient funds");
        // 再验证授权金额是否足够
        require(
            _allowances[from][msg.sender] >= value,
            "Not sufficient approved funds"
        );
        // 转账
        _balance[from] -= value;
        _balance[to] += value;
        _allowances[from][msg.sender] -= value;
        return true;
    }

    // 铸造token
    function mint(address to, uint256 value) public {
        require(msg.sender == _owner, "Only owner can operate");
        _balance[to] += value;
        _totalSupply += value;
    }
}
