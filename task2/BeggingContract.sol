// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

// 讨饭合约
contract BeggingContract {
    // 捐赠者的捐赠金额
    mapping(address => uint256) amounts;
    // 所有者
    address owner;

    constructor() {
        owner = msg.sender;
    }

    // 记录捐赠信息
    function donate() public payable {
        amounts[msg.sender] += msg.value;
    }

    // 合约所有者提取所有资金
    function withdraw() public payable {
        require(owner == msg.sender, "Only owner can operate");
        payable(msg.sender).transfer(address(this).balance);
    }

    // 查询某个地址的捐赠金额
    function getDonation(address addr) public view returns (uint256) {
        return amounts[addr];
    }
}
