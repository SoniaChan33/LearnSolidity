// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConvertor} from "./PriceConvertor.sol";

contract FundMe{

    address public owner;

    constructor () {
        owner = msg.sender;
    }

    // 表示所有uint256类型可以调用该library的函数
    using PriceConvertor for uint256;

    address[] public funders; 

    mapping(address funderAddress => uint256 funderAmount) public funderAmountMap;

    uint256 public  minimumUsd = 5 * 1e18;
    
    function fund() public payable {
        require(msg.value.getConversionRate() > minimumUsd, "Didn't send enough ETH"); //if the condition is false, revert with the error message    }
    
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
    }

    // 任何由onlyOwner修饰都会先执行这部分代码，“_;”代表被修饰的函数的代码，放在require之前就是先执行完函数代码再执行modifier代码块中内容
    modifier onlyOwner {
        require(msg.sender == owner,"Must be the Owner!");
        _;
    }
}