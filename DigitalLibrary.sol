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

error You_Are_Not_Author();
error You_Are_Not_Librarian();

contract DigitalLibrary {
    uint256 private id;
    uint256 private expirationDays;
    mapping(uint256 => EBook) private libraryBooks;

    constructor(uint256 _expirationDays) {
        expirationDays = _expirationDays;
    }

    function getLibraryBook(uint256 _bookId)
        public
        view
        returns (
            string memory title__,
            string memory author__,
            uint256 publicationDate__,
            uint256 expirationDate__,
            State status__,
            address[] memory librarians__,
            uint256 readCount__)
    {
        require(libraryBooks[_bookId].primaryLibrarian == msg.sender);
        return (
            libraryBooks[_bookId].title,
            libraryBooks[_bookId].author,
            libraryBooks[_bookId].publicationDate,
            libraryBooks[_bookId].expirationDate,
            libraryBooks[_bookId].status,
            libraryBooks[_bookId].librarians,
            libraryBooks[_bookId].readCount
        );
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

    function addLibrarian(uint256 _bookId, address _librarian)
        public
        returns (address[] memory librarians)
    {
        libraryBooks[_bookId].librarians.push(_librarian);
        if (libraryBooks[_bookId].primaryLibrarian != msg.sender) {
            revert You_Are_Not_Author();
        }
        return libraryBooks[_bookId].librarians;
    }

    function getLibrarians(uint256 _bookId)
        public
        view
        returns (address[] memory librarians)
    {
        return libraryBooks[_bookId].librarians;
    }

    function extendExpirationDate(uint256 _bookId, uint256 _addExpirationDays)
        public
        returns (bool success)
    {
        libraryBooks[_bookId].expirationDate += _addExpirationDays * 1 days;
        for (uint256 i = 0; i < libraryBooks[_bookId].librarians.length; i++) {
            if (libraryBooks[_bookId].librarians[i] == msg.sender) {
                return true;
            }
            revert You_Are_Not_Librarian();
        }
    }
}

//  0x5B38Da6a701c568545dCfcB03FcB875f56beddC4

//  0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
//  0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
//  0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB
