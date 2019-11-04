pragma solidity ^0.4.24;

import "./SafeMath.sol";
// @title the berithBank contract for test berith mainNet
// @author sykang4966@naver.com
// @notiec Test code for deposit and withdrawal function
contract ledger {
    using SafeMath for uint256;
    
    struct history {
        uint256 block_num;
        bool plus;
        uint256 amount;
        uint256 before_balance;
        uint256 after_balance;
    }
    
    address public president;
    
    mapping(address => history[]) public ledgers;
    mapping(address => uint256) public his_count;

    constructor() public {
        president = msg.sender;
    }

    function setHistory(bool _exist, bool _plus, uint _amount, uint _after_balance, address _addr)
    external {

        if(_exist){ //계좌내역이 존재
            uint256 tmp_balance;
            if(_plus){
                tmp_balance = _after_balance.sub(_amount);
            }else{
                tmp_balance = _after_balance.add(_amount);
            }
            
            ledgers[_addr].push(history({
                block_num: his_count[_addr].add(1),
                plus: _plus,
                amount: _amount,
                before_balance: tmp_balance,
                after_balance: _after_balance
            }));
            
            his_count[_addr] = his_count[_addr].add(1);
        }else{
            require(_plus);

            ledgers[_addr].push(history({
                block_num: 0,
                plus: _plus,
                amount: _amount,
                before_balance: 0,
                after_balance: _amount
            }));
        }
    }
}