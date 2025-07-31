// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import "forge-std/Test.sol";
import "../contracts/DepositRangeTrap.sol";

contract DepositRangeTrapTest is Test {
    DepositRangeTrap trap;
    address alice = address(0xA11CE);

    function setUp() public {
        trap = new DepositRangeTrap(0.01 ether, 1 ether);
        vm.deal(alice, 1 ether);
    }

    function testAcceptsInRangeDeposit() public {
        vm.prank(alice);
        (bool success,) = address(trap).call{value: 0.5 ether}("");
        assertTrue(success);
        assertEq(address(trap).balance, 0.5 ether);
    }

    function testRefundsIfBelowMinimum() public {
        vm.prank(alice);
        (bool sent,) = address(trap).call{value: 0.005 ether}("");
        assertTrue(sent);

        bytes memory data = trap.collect();
        assertTrue(trap.shouldRespond(data));

        uint256 before = alice.balance;
        trap.respond(data);
        uint256 after = alice.balance;

        assertGt(after, before);
    }

    function testRefundsIfAboveMaximum() public {
        vm.prank(alice);
        (bool sent,) = address(trap).call{value: 2 ether}("");
        assertTrue(sent);

        bytes memory data = trap.collect();
        assertTrue(trap.shouldRespond(data));

        uint256 before = alice.balance;
        trap.respond(data);
        uint256 after = alice.balance;

        assertGt(after, before);
    }
}
