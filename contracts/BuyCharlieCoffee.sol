// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract BuyCharlieCoffee {
    //emit event on Memo
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );        

    //Memo struct
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    //List of all memos received
    Memo[] memos;

    //address of contract deployer
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }
    
    // @dev buy coffee for contract owner
    // @param _name of buyer
    // @param _message from buyer
    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "I can't buy coffee with zero ETH.");

        //add memo to storage
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        //log event of new memo creation
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    // @dev send full balance to owner    
    function withdrawTips() public {        
        require(owner.send(address(this).balance));
    }

    // @dev retreive memos from blockchain  
    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }
}