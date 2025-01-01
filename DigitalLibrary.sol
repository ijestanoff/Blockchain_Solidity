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

    function addLibrarian(uint256 _id, address _librarian) public{
        libraryBooks[_id].librarians.push(_librarian);
        if (libraryBooks[_id].primaryLibrarian != msg.sender) {
            revert YouAreNotAuthor();
        }
    }
}


