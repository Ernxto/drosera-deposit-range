// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract DepositRangeTrap {
    uint256 public minDeposit;
    uint256 public maxDeposit;

    struct Deposit {
        address sender;
        uint256 amount;
    }

    Deposit[] public deposits;

    event DepositReceived(address indexed sender, uint256 amount);
    event Refunded(address indexed to, uint256 amount);

    constructor(uint256 _minDeposit, uint256 _maxDeposit) {
        require(_minDeposit < _maxDeposit, "Invalid range");
        minDeposit = _minDeposit;
        maxDeposit = _maxDeposit;
    }

    receive() external payable {
        deposits.push(Deposit(msg.sender, msg.value));
        emit DepositReceived(msg.sender, msg.value);
    }

    function collect() external view returns (bytes memory) {
        if (deposits.length == 0) return "";
        Deposit memory last = deposits[deposits.length - 1];
        return abi.encode(last.sender, last.amount);
    }

    function shouldRespond(bytes memory data) external view returns (bool) {
        (address sender, uint256 amount) = abi.decode(data, (address, uint256));
        return (amount < minDeposit || amount > maxDeposit);
    }

    function respond(bytes memory data) external {
        (address sender, uint256 amount) = abi.decode(data, (address, uint256));
        require(amount < minDeposit || amount > maxDeposit, "No refund needed");

        (bool sent, ) = sender.call{value: amount}("");
        require(sent, "Refund failed");

        emit Refunded(sender, amount);
    }

    function depositCount() external view returns (uint256) {
        return deposits.length;
    }

    function withdraw() external {
        payable(msg.sender).transfer(address(this).balance);
    }
}
