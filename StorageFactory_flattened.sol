
// File: SimpleStorage.sol


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
    function retrieve() public view returns (uint256) {
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
contract SimpleStorage2{

}
// File: StorageFactory.sol


pragma solidity ^0.8.18;


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