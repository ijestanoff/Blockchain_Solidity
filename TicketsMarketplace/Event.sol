// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

error NoMoreTickets();
contract Event is ERC721, Ownable {
    uint256 private _nextTokenId;
    // date is timestamp
    uint256 public immutable date;
    string public location;
    uint256 ticketAvailability;


    constructor(address eventOrganizer, string memory eventName, uint256 date_, string memory location_)
        ERC721(eventName, "")
        Ownable(eventOrganizer)
    {
        date = date_;
        location = location_;
        // ticketAvailability = ; 
    }

    function safeMint(address to) public onlyOwner {
        if(_nextTokenId > ticketAvailability) {
            revert NoMoreTickets();
        }
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
    }
}