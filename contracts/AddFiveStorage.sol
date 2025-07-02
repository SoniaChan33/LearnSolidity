
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {SimpleStorage} from "./SimpleStorage.sol";

// is关键字表示继承
contract AddFiveStorage is SimpleStorage {

    // override关键字表示重写
    function store(uint256 _myFavoriteNumber) public override {
        myFavoriteNumber = _myFavoriteNumber + 5;
    }

}