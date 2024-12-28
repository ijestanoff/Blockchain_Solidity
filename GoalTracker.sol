// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

error NegativeAmount();
error Not_enough_spending_for_reward();

contract goalTracker {
    uint256 public goalAmount = 1000;
    uint256 public rewardAmount = 20;
    uint256 public totalSpend;

    function addSpending(uint256 amount) public {
        if (amount > 0) {
            totalSpend += amount;
        } else revert NegativeAmount();
    }

    function claimReward() public returns (uint256 reward) {
        uint256 i;
        if (totalSpend >= goalAmount) {
            for (i = 0; i < totalSpend / goalAmount; i++) {
                reward += rewardAmount;
            }
            totalSpend -= goalAmount * i;
            return reward;
        } else revert Not_enough_spending_for_reward();
    }
}
