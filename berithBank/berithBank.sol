pragma solidity ^ 0.4.24;

import "./SafeMath.sol";
import "./ledger.sol";

// @title the berithBank contract for test berith mainNet
// @author sykang4966@naver.com
// @notiec Test code for deposit and withdrawal function
contract berithBank {
    using SafeMath for uint256;

    struct Accounts { // 은행계좌
        bool exist; // 계좌 생성 여부
        address owner; // 계좌 소유 주 주소
        uint256 total_fund; // 총 금액
    }

    // public variables
    address public president; // 은행장
    address public ledger_addr; // ledger contract address
    ledger ledger_object;

    mapping(address => Accounts) public account; // 주소 별 계좌

    constructor(address _ledger_addr) public {
        president = msg.sender;
        ledger_addr = _ledger_addr;
        ledger_object = ledger(_ledger_addr);
    }

    function deposit()
    payable external {
        address sender = msg.sender; // 보낸 사람
        uint256 amount = msg.value; // 입금 금액

        Accounts storage account_data = account[sender];

        if(account_data.exist == true) { // 기존 계좌가 있다면
            require(account_data.owner == sender);
            account_data.total_fund = account_data.total_fund.add(amount);
        } else { // 기존 계좌가 없다면
            account_data.exist = true;
            account_data.owner = sender;
            account_data.total_fund = amount;
        }
        account[sender] = account_data;
        ledger_object.setHistory(account_data.exist, true, amount, account_data.total_fund, sender );
    }

    function withdraw(uint256 _value) 
    external {
        address receiver = msg.sender; // 송신 계좌

        Accounts storage account_data = account[receiver];
        require(account_data.owner == receiver);

        if(account_data.exist == true) {
            if(account_data.total_fund.sub(_value) >= 0){
                account_data.total_fund = account_data.total_fund.sub(_value);
            } else {
                revert();
            }
        } else {
            revert();
        }
        account[receiver] = account_data;
        ledger_object.setHistory(true, false, _value, account_data.total_fund, receiver);
        receiver.transfer(_value);
    }
}