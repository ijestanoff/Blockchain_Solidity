// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

error InvalidRating();
error InvalidSalary();
error CannotBeSplitEvenly();

contract CompoundInterestCalculator {
     

    function calculateCompoundInterest(
        uint256 principal,
        uint256 rate,
        uint256 year_s
    ) public pure returns (uint256 balance) {
        principal *= 1000;
        for (uint256 i = 0; i < year_s; i++) {
            principal = (principal * (100 + rate))/100;
        }
        return principal;
    }

    function calculatePaycheck(int256 salary, int256 rating) public pure returns (int256 paycheck) {
        if (rating>8 && rating<=10 ){
            salary += salary/10;
        } else {
            revert InvalidRating();
        }
        if (salary<0) {
            revert InvalidSalary();
        }
        return salary;
    }

    function splitExpense (int256 totalAmount, int256 numPeople) public pure returns (int256 divideAmount) {
        if (totalAmount % numPeople == 0){
            return (totalAmount/numPeople);
        } else {
            revert CannotBeSplitEvenly();
        }
    }
}
