1. 스마트 컨트렉트 DEPLOY 하는 순서
    1. 네트워크 활성화(노드 실행)하여 attach로 접근하여 콘솔환경을 갖춘다.
    2. 디플로이 순서는 ledger.sol => berithBank.sol(생성자 인자에 ledger contract address) 
    3. 디플로이에 필요한 abi파일과 bin파일 내부 소스를 활용하여 디플로이한다.
    
2. berithBank.sol 매소드 설명
    1. deposit : 입금 메소드, value에 입력한 값 만큼 입금된다.
    2. withdraw(출금금액_wei 단위) : 인자로 인출값을 넣어주면 넣어준 만큼 출금된다.
    3. account(주소) : 인자로 주소를 넣으면 보관된 금액이 나온다.
    4. lefger_addr : ledger(장부)컨트렉트 주소
    5. president : 은행장(berithBank 컨트렉트 소유주 주소)
    
3. ledger.sol. 메소드 설명
    1. setHistory : berithBank의 입출금 기록을 기록하는 메소드이다
                    berithBank의 입출금이 발생할때 컨트렉트간 통신으로 기록된다.
    2. his_count(주소) : 인자로 입력받은 해당 계좌의 가장 최신 입출금 기록 카운트를알려준다.
    3. ledgers(주소, 넘버) : 주소의 넘버에 해당하는 입출금 기록을 보여준다.
