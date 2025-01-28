// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

import {Event} from "./Event.sol";

error InvalidInput(string info);
error AlreadyListed();
error MustBeOrganizer();

enum BuyingOption {
    FixedPrice,
    Bidding
}

struct EventData {
    uint256 ticketPrice;
    BuyingOption saleType;
    uint256 salesEnds; //timestamp
}

contract Marketplace {
    uint256 constant MIN_SALE_PERIOD = 24 hours;
    mapping(address => EventData) public events;

    function createEvent(
        string memory eventName,
        uint256 date,
        string memory location,
        uint256 ticketPrice,
        BuyingOption saleType,
        uint256 salesEnds
    ) external {
        address newEvent = address(
            new Event(address(this), eventName, date, location, msg.sender)
        );

        _listEvent(newEvent, ticketPrice, saleType, salesEnds);
    }

    function listEvent(
        address newEvent,
        uint256 ticketPrice,
        BuyingOption saleType,
        uint256 salesEnds
    ) external {
        if (msg.sender != Event(newEvent).organizer()) {
            revert MustBeOrganizer();
        }
        
        _listEvent(newEvent, ticketPrice, saleType, salesEnds);
    }

    function _listEvent(
        address newEvent,
        uint256 ticketPrice,
        BuyingOption saleType,
        uint256 salesEnds
    ) internal {
        if (salesEnds > block.timestamp + MIN_SALE_PERIOD) {
            revert InvalidInput("salesEnd is invalid");
        }
        if (events[newEvent].salesEnds != 0) {
            revert AlreadyListed();
        }

        events[newEvent] = EventData({
            ticketPrice: ticketPrice,
            saleType: saleType,
            salesEnds: salesEnds
        });
    }
}
