// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log ..
// import "hardhat/console.sol";
// import "./library/BinarySearchTree.sol";

contract Fairplay {
    enum Gender {
        Male, // 0
        Female // 1
    }

    struct player {
        address addr;
        string name; // short name (up to 32 bytes)
        uint dob; //  uint date = 1638352800; // 2012-12-01 10:00:00
        Gender gender; // Male/Female; 0/1
        uint last_location; // https://stackoverflow.com/questions/8285599/
        string uri;
    }

    mapping(address => player) public users;
    mapping(address => address[]) public match_pool_users;
    mapping(address => bool) public is_added;

    function getLastLocation(address addr) public view returns (uint) {
        return users[addr].last_location;
    }

    function getUser() public view returns (player memory) {
        return users[msg.sender];
    }

    function addUser(
        string calldata name,
        uint dob,
        Gender gender,
        uint last_location
    ) public {
        require(is_added[msg.sender] != true);
        users[msg.sender] = player({
            addr: msg.sender,
            name: name,
            dob: dob,
            gender: gender,
            last_location: last_location,
            uri: ''
        });
        is_added[msg.sender] = true;
    }

    function generateMatchPool(uint search_radius) public {}

    function getMatchPool() public view returns (address[] memory) {
        return match_pool_users[msg.sender];
    }
}
