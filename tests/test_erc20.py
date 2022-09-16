import pytest

_NAME = "first-erc20"
_SYMBOL = "FE"
_DECIMALS = 18
_TOTAL_SUPPLY = 1e24


@pytest.fixture
def erc20_contract(Erc20, accounts):
    yield Erc20.deploy(_SYMBOL, _NAME, _DECIMALS, _TOTAL_SUPPLY, {'from': accounts[0]})

def test_token_name(erc20_contract):
    assert erc20_contract.name() == _NAME
    
def test_token_symbol(erc20_contract):
    assert erc20_contract.symbol() == _SYMBOL
    
def test_token_decimals(erc20_contract):
    assert erc20_contract.decimals() == _DECIMALS
    
def test_token_total_supply(erc20_contract):
    assert erc20_contract.totalSupply() == _TOTAL_SUPPLY

def test_token_minter_balance(erc20_contract, accounts):
    assert erc20_contract.balanceOf(accounts[0]) == _TOTAL_SUPPLY
    assert erc20_contract.totalSupply() == _TOTAL_SUPPLY

def test_fail_minter_balance(erc20_contract, accounts):
    assert not erc20_contract.balanceOf(accounts[1]) == _TOTAL_SUPPLY

def test_transfer(erc20_contract, accounts):
    erc20_contract.transfer(accounts[1], 1e18, {'from':accounts[0]})
    assert erc20_contract.balanceOf(accounts[1]) == 1e18
    assert erc20_contract.balanceOf(accounts[0]) == (1e24 - 1e18)

def test_exception_transfer_from(erc20_contract, accounts):
    with pytest.raises(Exception) :
        res = erc20_contract.transferFrom(accounts[0], accounts[2], 2e18, {'from': accounts[3]})

def test_allowance_and_transfer_from(erc20_contract, accounts):
    res = erc20_contract.approve(accounts[3], 5e18, {'from': accounts[0]})
    assert res
    res = erc20_contract.transferFrom(accounts[0], accounts[2], 2e18, {'from': accounts[3]})
    assert res
    assert erc20_contract.balanceOf(accounts[2]) == 2e18