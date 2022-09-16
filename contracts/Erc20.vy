# @version 0.3.6
import interfaces.IERC20 as IERC20

implements: IERC20

event Transfer:
    _from: indexed(address)
    _to: indexed(address)
    _amount: uint256

event Approval:
    _owner: indexed(address)
    _spender: indexed(address)
    _amount: uint256

symbol: public(String[32])
name: public(String[64])
decimals: public(uint8)
totalSupply: public(uint256)
balances: public(HashMap[address, uint256])
allowances: public(HashMap[address, HashMap[address, uint256]])

@external
def __init__(_symbol: String[32], _name: String[64], _decimals: uint8, _totalSupply: uint256):
    self.symbol = _symbol
    self.name = _name
    self.decimals = _decimals
    self.totalSupply = _totalSupply
    self.balances[msg.sender] = self.totalSupply
    log Transfer(empty(address), msg.sender, self.totalSupply)

@view
@external
def balanceOf(_owner: address) -> uint256:
    return self.balances[_owner]

@external
def transfer(_to: address, _amount: uint256) -> bool:
    
    self.balances[msg.sender] -= _amount
    self.balances[_to] = _amount
    log Transfer(msg.sender, _to, _amount)
    return True

@external
def approve(_spender: address, _amount: uint256) -> bool:
    self.allowances[msg.sender][_spender] += _amount
    log Approval(msg.sender, _spender, _amount)
    return True

@view
@external
def allowance(_owner: address, _spender: address) -> uint256:
    return self.allowances[_owner][_spender]

@external
def transferFrom(_from: address, _to: address, _amount: uint256) -> bool:

    self.allowances[_from][msg.sender] -= _amount
    self.balances[_from] -= _amount
    self.balances[_to] += _amount
    log Transfer(_from, _to, _amount)
    return True
