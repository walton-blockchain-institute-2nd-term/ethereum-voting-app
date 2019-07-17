// 솔리디티 버전
pragma solidity >=0.4.0 <0.6.0;

// Voting 컨트랙트 생성
contract Voting {
    // key(bytes32)와 value (uint256)로 구성되어 있음
    // bytes32에 uint256 값이 저장
    mapping (bytes32 => uint256) public votesReceived;

    // bytes32[] public 배열
    bytes32[] public candidateList;

    // constructor란 contract 배포 시 한번만 실행되는 생성자
    // bytes32[] 배열을 매개변수로 받는 public 생성자
    // memory는 변수를 storage에 저장하지 않고, 함수 내에서만 사용할 수 있도록 하는 변수
    constructor(bytes32[] memory candidateNames) public {
        // 매개변수 candidateNames를 candidateList에 저장
        candidateList = candidateNames;
    }

    // view는 데이터를 변경하지 않고 불러오기만 한다는 뜻
    // view 함수는 트랜잭션을 일으키지 않음
    // bytes32 매개변수를 받고 uint256을 리턴하는 public 함수
    function totalVotesFor(bytes32 candidate) public view returns (uint256) {
        // require(~)의 값이 true면 (입력한 candidate가 candidateList에 있으면) 함수 다음 줄 실행
        // false면 에러 메시지를 출력하고 함수 실행을 종료
        require(validCandidate(candidate), "후보자 리스트에 존재하는 값만 입력해 주세요.");
        // candidate를 key로 하고 uint256을 value로 저장
        // mapping한 uint256을 리턴
        return votesReceived[candidate];
    }

    // bytes32 매개변수를 받는 public 함수
    function voteForCandidate(bytes32 candidate) public {
        // require(~)의 값이 true면 (입력한 candidate가 candidateList에 있으면) 함수 다음 줄 실행
        // false면 에러 메시지를 출력하고 함수 실행을 종료
        require(validCandidate(candidate), "후보자 리스트에 존재하는 값만 입력해 주세요.");
        // candidate(bytes32)에 대한 uint256 값을 1 증가시킴
        votesReceived[candidate] += 1;
    }

    // bytes32 매개변수를 받고 bool을 리턴하는 public 함수
    // view 함수이기 때문에 데이터를 변경하지 않고 불러오기만 함
    function validCandidate(bytes32 candidate) public view returns (bool) {
        // candidateList 안의 갯수 반복
        for(uint i = 0; i < candidateList.length; i++) {
            // 입력 받은 매개변수와 candidateList에 있는 값이 같으면 true를 리턴
            if(candidateList[i] == candidate) {
                return true;
            }
        }
        // for문이 끝나면 (입력 받은 매개변수가 candidateList에 있는 값 중에 없을 경우) false를 리턴
        return false;
    }
}
