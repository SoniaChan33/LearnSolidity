// SPDX-License-Identifier: MIT
pragma solidity 0.8.19; // stating our version 

contract SimpleStorage {
    uint256 public myFavoriteNumber; // 初始值就是0 而且是internal 也就是内部不可见的


    // 数组
    uint256[] public myFavoriteNumbers;

    // 结构
    struct Person {
        uint256 personNumber;
        string name;
    }

    Person public newPerson = Person(1, 'jack');

    Person public myPerson;

    Person[] public myPersonArray;

    // mapping 
    mapping(string => uint256) public nameToFavoriteNumber;


    function store(uint256 favoriteNumber) public virtual  {// 存储
        myFavoriteNumber = favoriteNumber;
    }

    // view 可读不可写 pure 不可读不可写
    function recive() public view returns (uint256) {
        return myFavoriteNumber;
    }


    // 存储位置 storege Calldata memory ... 区别 storage 存储整个  calldata只在一次请求中存储
    function addPerson(string memory name, uint256 _favoriteNumber) public {
        myPerson = Person(_favoriteNumber, name);
        nameToFavoriteNumber[name] = _favoriteNumber;
    }

    // 存储最爱的数字
    function setPersion(string memory name, uint256 _favoriteNumber) public {
        
    }

    




}