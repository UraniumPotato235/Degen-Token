// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DegenToken {
    string public name;
    string public symbol;
    uint256 public totalSupply;
    address public owner;

    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowance;


    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    constructor() 
    {
        name = "Degen";
        symbol = "DEG";
        owner = msg.sender;
        
    }

    function transfer(address _to, uint256 _value) external returns (bool success) {
        require(_to != address(0), "Invalid recipient address");
        require(_value <= balances[msg.sender], "Insufficient balance");

        balances[msg.sender] -= _value;
        balances[_to] += _value;

    
        return true;
    }

    function approve(address _spender, uint256 _value) external returns (bool success) {
        require(_spender != address(0), "Invalid spender address");

        allowance[msg.sender][_spender] = _value;

        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success) {
        require(_to != address(0), "Invalid recipient address");
        require(_value <= balances[_from], "Insufficient balance");
        require(_value <= allowance[_from][msg.sender], "Insufficient allowance");

        balances[_from] -= _value;
        balances[_to] += _value;
        allowance[_from][msg.sender] -= _value;

        return true;
    }

    function mint(address _to, uint256 _value) external onlyOwner returns (bool success) {
        require(_to != address(0), "Invalid recipient address");

        balances[_to] += _value;
        totalSupply += _value;

        return true;
    }

    function redeem(uint256 _value) external returns (bool success) {
        require(_value <= balances[msg.sender], "Insufficient balance");

        balances[msg.sender] -= _value;
        totalSupply -= _value;

        return true;
    }

    function burn(uint256 _value) external returns (bool success) {
        require(_value <= balances[msg.sender], "Insufficient balance");

        balances[msg.sender] -= _value;
        totalSupply -= _value;

        return true;
    }
}