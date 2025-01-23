// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

import {Event} from "./Event.sol";

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
    mapping(address => EventData) public events;

    function createEvent(
        string memory eventName,
        uint256 date,
        string memory location
    ) external {
        address newEvent = address(
            new Event(address(this), eventName, date, location, msg.sender)
        );
    }
}
