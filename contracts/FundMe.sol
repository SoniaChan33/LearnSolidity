// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe{


    uint256 public  minimumUsd = 5 * 1e18;
    
    function fund() public payable {
        require(getConversionRate(msg.value) > minimumUsd, "Didn't send enough ETH"); //if the condition is false, revert with the error message    }
    }

    function withDraw() public {

    }

    // 获取当前的eth对应实际世界的美元价格
    function getPrice() public view returns(uint256) {
        AggregatorV3Interface addressToBeFetched = AggregatorV3Interface(0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43);
        (, int256 answer,,,) = addressToBeFetched.latestRoundData(); // ( ,,,, , )  取出地址，值，错误码等
        return uint256(answer * 1e18);
    }

    function getConversionRate(uint256 usdDollar) public view returns(uint256) {
        uint256 ethPrice = getPrice();
        return (ethPrice*usdDollar)/1e18;
    }

}