// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConvertor} from "./PriceConvertor.sol";

contract FundMe{

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

    function withDraw() public {

        //  Reset the funder records
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex ++) {
            address funder = funders[funderIndex];
            funderAmountMap[funder] = 0;
        }
        // reset the array
        funders = new address[](0);
    }

}