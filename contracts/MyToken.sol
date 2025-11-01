// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract TransparentCharity {
    address public owner;
    address public beneficiary;
    uint256 public totalDonated;
    uint256 public goalAmount; // Ví dụ: 100 CELO * 10^18 để theo dõi milestone

    struct Donation {
        uint256 amount;
        string message; // Độc đáo: Tin nhắn tùy chọn từ donor để kể chuyện tác động
    }
    mapping(address => Donation) public donations; // Theo dõi per donor (một lần donate/địa chỉ cho đơn giản)

    event Donated(address indexed donor, uint256 amount, string message, uint256 timestamp);
    event FundsWithdrawn(address indexed beneficiary, uint256 amount);
    event GoalReached(uint256 goal);

    modifier onlyOwner() {
        require(msg.sender == owner, unicode"Chỉ owner mới gọi được");
        _;
    }

    constructor(address _beneficiary, uint256 _goalAmount) {
        owner = msg.sender;
        beneficiary = _beneficiary;
        goalAmount = _goalAmount * 1 ether; // Chuyển sang wei (giả sử decimals CELO)
    }

    // Donate CELO với tin nhắn tùy chọn
    function donate(string calldata _message) external payable {
        require(msg.value > 0, unicode"Số tiền donate phải > 0");
        
        donations[msg.sender] = Donation({
            amount: msg.value,
            message: _message
        });
        
        totalDonated += msg.value;
        
        emit Donated(msg.sender, msg.value, _message, block.timestamp);
        
        if (totalDonated >= goalAmount) {
            emit GoalReached(goalAmount);
        }
    }

    // Rút hết tiền đến beneficiary (chỉ admin)
    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, unicode"Không có tiền để rút");
        
        payable(beneficiary).transfer(balance);
        emit FundsWithdrawn(beneficiary, balance);
    }

    // Hàm đọc để minh bạch
    function getDonorInfo(address _donor) external view returns (uint256 amount, string memory message) {
        Donation memory donor = donations[_donor];
        return (donor.amount, donor.message);
    }

    function getProgress() external view returns (uint256 current, uint256 goal, uint256 percentage) {
        if (goalAmount > 0) {
            percentage = (totalDonated * 100) / goalAmount;
        }
        return (totalDonated, goalAmount, percentage);
    }
}