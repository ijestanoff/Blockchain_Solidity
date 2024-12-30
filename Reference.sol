// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

struct Vote {
    address shareholder;
    uint256 shares;
    uint256 timestamp;
    // TestA a;
    // mapping (uint256 => uint256) testaa;
}

struct TestA {
    uint256 a;
}

contract Test {
    uint256[5] public arr = [1, 2, 3, 4, 5];

    uint256[] public dynamicArr = [1, 2, 3, 4, 5];

    function addNumberDynamic(uint256 value)
        external
        returns (uint256[] memory)
    {
        dynamicArr.push(value);
        return dynamicArr;
    }

    function removeArr() external returns (uint256[] memory) {
        dynamicArr.pop();
        return dynamicArr;
    }

    function addNumber() external view returns (uint256) {
        uint256 res;
        for (uint256 i = 0; i < arr.length; i++) {
            res += arr[i];
        }
        return res;
    }
}

contract Crowdfundings {
    mapping(address => uint256) public shares;
    Vote[] public votes;
    // mapping(address => uint256) public shares2;
    uint256 public sharePrice;
    uint256 public totalShares;

    constructor(uint256 _sharePrice) {
        sharePrice = _sharePrice;
    }

    function addShares() external payable {
        totalShares += msg.value;
        shares[msg.sender] += msg.value;
    }

    function vote(address holder) external {
        votes.push(
            Vote({
                shareholder: holder,
                shares: shares[holder],
                timestamp: block.timestamp
            })
        );
        // emit NewVote(shareholder, 1);
    }

    function addShares(address receiver, uint256 amount) external {
        // totalShares += amount;
        shares[receiver] += amount;
    }

    function getUserShares(address user) external view returns (uint256) {
        return shares[user];
    }
}

contract ArrayMy {
    uint256[] public arr = [1, 2, 3, 4, 5];

    function checkArr(uint256[] calldata _arr)
        external
        returns (uint256[] memory)
    {
        arr = _arr;

        return arr;
    }
}
