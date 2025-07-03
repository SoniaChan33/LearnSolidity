// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

// 所有函数都需要是interal
library PriceConvertor {


    // 获取当前的eth对应现实世界的美元价格
    // 获取价格的地址从 https://docs.chain.link/data-feeds/price-feeds/addresses?page=1&testnetPage=1 这里获取ETH/USD的价格
    function getPrice() internal  view returns(uint256) {
        AggregatorV3Interface addressToBeFetched = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 answer,,,) = addressToBeFetched.latestRoundData(); // ( ,,,, , )  取出地址，值，错误码等
        return uint256(answer * 1e18);
    }

    function getConversionRate(uint256 usdDollar) internal view returns(uint256) {
        uint256 ethPrice = getPrice();
        return (ethPrice*usdDollar)/1e18;
    }
}