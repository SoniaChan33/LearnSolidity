// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract FundMe{


    uint256 public  myvalue = 1;
    function fund() public payable {
        myvalue  += 2;
        require(msg.value > 1 ether, "Didn't send enough ETH"); //if the condition is false, revert with the error message    }
    }

    function withDraw() public {

    }
}