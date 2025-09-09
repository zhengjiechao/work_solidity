// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting{
    // 存储候选人的得票数
    mapping(address => uint256) public voting;
    // 候选人数组
    address[] public candidateArr;

    // 允许用户投票给某个候选人
    function vate(address candidate) public {
        voting[candidate]++;
        if (voting[candidate] == 1){
            candidateArr.push(candidate);
        }
    }

    // 返回某个候选人的得票数
    function getVotes(address candidate) public view returns(uint256){
        return voting[candidate];
    }

    // 重置所有候选人的得票数
    function resetVotes() public {
        for(uint i= 0;i<candidateArr.length;i++){
            voting[candidateArr[i]] = 0;
        }
    }
}