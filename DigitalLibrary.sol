// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

enum State {
    Active,
    Outdated,
    Archived
}

struct EBook {
    string title;
    string author;
    uint256 publicationDate;
    uint256 expirationDate;
    State status;
    address primaryLibrarian;
    address[] librarians;
    uint256 readCount;
}

error YouAreNotAuthor();

contract DigitalLibrary {
    uint256 private id;
    uint256 private expirationDays;
    mapping(uint256 => EBook) public libraryBooks;

    constructor(uint256 _expirationDays) {
        expirationDays = _expirationDays;
    }

    function createEBook(string calldata _title, string calldata _author)
        public
    {
        libraryBooks[id].title = _title;
        libraryBooks[id].author = _author;
        libraryBooks[id].publicationDate = block.timestamp;
        libraryBooks[id].expirationDate =
            libraryBooks[id].publicationDate +
            expirationDays *
            1 days;
        libraryBooks[id].status = State.Active;
        libraryBooks[id].primaryLibrarian = msg.sender;
        id++;
    }

    function addLibrarian(uint256 _id, address _librarian)
        public
        returns (EBook memory book)
    {
        libraryBooks[_id].librarians.push(_librarian);
        if (libraryBooks[_id].primaryLibrarian != msg.sender) {
            revert YouAreNotAuthor();
        }
        return libraryBooks[_id];
    }

    function getLibrarians(uint256 _id, uint256 _index) public view returns (address) {
        return libraryBooks[_id].librarians[_index];
    }
}

//  0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
//  0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
//  0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB