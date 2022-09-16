interface IERC20:
    def totalSupply() -> uint256: view
    def symbol() ->  String[32]: view
    def name() -> String[64]: view
    def transfer(_to: address, _amount: uint256) -> bool: nonpayable
    def transferFrom(_from: address, _to: address, _amount: uint256) -> bool: nonpayable
    def approve(_spender: address, _amount: uint256) -> bool:  nonpayable
    def allowance(_owner: address, _spender: address) -> uint256: view
    def decimals() -> uint256: view


