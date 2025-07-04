// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConvertor} from "./PriceConvertor.sol";

// custom errors
error NotTheOwner();
contract FundMe{

    // immutable 适用于部署时设置且不变的值 
    address public immutable i_owner;

    constructor () {
        i_owner = msg.sender;
    }

    // 表示所有uint256类型可以调用该library的函数
    using PriceConvertor for uint256;

    address[] public funders; 

    mapping(address funderAddress => uint256 funderAmount) public funderAmountMap;

    // constant 使用于在编译时已确认的值 并且需要大写
    uint256 public constant  MINIMUM_USD = 5 * 1e18;
    
    function fund() public payable {
        require(msg.value.getConversionRate() > MINIMUM_USD, "Didn't send enough ETH"); //if the condition is false, revert with the error message    }
    
        funders.push(msg.sender);
        funderAmountMap[msg.sender] += msg.value;
    }

    function withDraw() public onlyOwner{

        //  Reset the funder records
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex ++) {
            address funder = funders[funderIndex];
            funderAmountMap[funder] = 0;
        }
        // reset the array
        funders = new address[](0);

        // send money to msg.sender[three ways]
        // transfer
            // payable(msg.sender).transfer(amount); // the current contract sends the Ether amount to the msg.sender
        // send
            // bool success = payable(msg.sender).send(address(this).balance); require(success, "Send failed");
        // call
        (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "Call failed");
    }

    // 任何由onlyOwner修饰都会先执行这部分代码，“_;”代表被修饰的函数的代码，放在require之前就是先执行完函数代码再执行modifier代码块中内容
    modifier onlyOwner {
        if (msg.sender != i_owner) {
            revert NotTheOwner();
        }
        // require(msg.sender == i_owner,"Must be the Owner!");
        _;
    }
}