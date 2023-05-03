// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log ..
// import "hardhat/console.sol";
import "./library/BinarySearchTree.sol";

contract Fairplay {
    BinarySearchTree.Tree tree;
    BinarySearchTree.Node[] node;

    mapping(address => BinarySearchTree.Node) public users;

    function getLastLocation(address addr) public view returns (uint) {
        return users[addr].last_location;
    }

    function addUser(
        bytes32 name,
        uint dob,
        BinarySearchTree.Gender gender,
        uint last_location
    ) public {
        BinarySearchTree.add(
            tree,
            msg.sender,
            name,
            dob,
            gender,
            last_location
        );
        users[msg.sender] = BinarySearchTree.Node({
            addr: msg.sender,
            name: name,
            dob: dob,
            gender: gender,
            last_location: last_location,
            left: 0,
            right: 0
        });
    }

    function findUsers() public {}
}
