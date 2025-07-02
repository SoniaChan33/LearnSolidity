// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {SimpleStorage} from "./SimpleStorage.sol";

// 存储工厂
// 创建storage合约的列表，并通过index调用特定storgae合约的函数
contract StorageFactory {

    SimpleStorage[] listOfSimpleStorageContracts;

    // 创建simpleStorage
    function createMyStorage() public {
        SimpleStorage myStorage = new SimpleStorage();
        listOfSimpleStorageContracts.push(myStorage);
    }

    // 调用特定合约的store函数
    function sfStore(uint256 _index, uint256 _myFavoriteNumber) public {
        listOfSimpleStorageContracts[_index].store(_myFavoriteNumber);
    }

    // 调用特定合约的recive函数
    function sfRetrieve(uint256 _index) public view returns(uint256) {
        return listOfSimpleStorageContracts[_index].retrieve();
    }


}