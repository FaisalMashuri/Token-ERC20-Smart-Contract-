// SPDX-License-Identifier: MIT
pragma solidity >=0.6.11 <0.7.0;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract IsalToken is  IERC20 {

  string public constant name = "IsalToken";
  string public constant symbol = "IFT";
  uint8 public constant decimals = 18;


  event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
  event Transfer(address indexed from,address indexed to, uint tokens);


  mapping(address => uint256) balances;

  mapping(address => mapping(address => uint256)) allowed;

  uint256 totalSupply_ = 200000000 ether;

  using SafeMath for uint256;

  constructor() public {
      balances[msg.sender] = totalSupply_;
  }

  function totalSupply() public override view returns (uint256){
      return totalSupply_;
  }

  function balanceOf(address tokenOwner) public override view returns (uint256) {
      return balances[tokenOwner];
  }

  function transfer(address reciever, uint256 numTokens) public override returns (bool){
      require(numTokens <= balances[msg.sender]);
      balances[msg.sender] = balances[msg.sender].sub(numTokens);
      balances[reciever] = balances[reciever].add(numTokens);
      emit Transfer(msg.sender,reciever, numTokens);
      return true;
  }

  function approve(address delegate, uint256 numTokens) public override returns (bool) {
      allowed[msg.sender][delegate] = numTokens;
      emit Approval(msg.sender, delegate, numTokens);
      return true;
  }

  function allowance(address owner, address delegate) public override view returns (uint) {
      return allowed[owner][delegate];
  }

  function transferFrom(address owner, address buyer, uint256 numTokens) public override returns (bool) {
      require(numTokens <= balances[owner]);
      require(numTokens <= allowed[owner][msg.sender]);

      balances[owner] = balances[owner].sub(numTokens);
      allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(numTokens);
      emit Transfer(owner, buyer, numTokens);
      return true;
  }
}