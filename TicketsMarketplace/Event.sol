// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

error NoMoreTickets();

contract Event is ERC721, Ownable {
    uint256 private _nextTokenId;

    // date is timestamp
    uint256 public immutable date;
    address public immutable organizer;
    bool public immutable isPriceCapSet;
    address public whiteListedAddress;

    string public location;
    uint256 ticketAvailability;

    constructor(
        address minter,
        string memory eventName,
        uint256 date_,
        string memory location_,
        address organizer_,
        bool isPriceCapSet_,
        address whiteListedAddress_
    ) ERC721(eventName, "") Ownable(minter) {
        date = date_;
        location = location_;
        organizer = organizer_;
        isPriceCapSet = isPriceCapSet_;
        if(isPriceCapSet) {
            whiteListedAddress = whiteListedAddress_;
        }
    }

    function safeMint(address to) public onlyOwner {
        if (_nextTokenId == ticketAvailability) {
            revert NoMoreTickets();
        }

        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
    }

    function _update(
        address to,
        uint256 tokenId,
        address auth
    ) internal override returns (address) {
        if(isPriceCapSet && msg.sender != owner() && to !=whiteListedAddress) {
            revert("invalid transfer (price cap)");
        }

        return super._update(to, tokenId, auth);
    }
}
