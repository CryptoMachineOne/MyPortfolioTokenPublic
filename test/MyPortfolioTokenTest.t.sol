 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/MyPortfolioToken.sol";

contract MyPortfolioTokenTest is Test {
    MyPortfolioToken token;

    address owner;
    address user;
    address attacker;

    uint256 constant INITIAL_SUPPLY = 1_000_000 ether;
    uint256 constant MAX_SUPPLY = 2_000_000 ether;

    function setUp() public {
        owner = address(this);
        user = address(1);
        attacker = address(2);

        token = new MyPortfolioToken();
    }

    // -----------------------------
    // DEPLOYMENT
    // -----------------------------

    function test_InitialSupply() public {
        assertEq(token.totalSupply(), INITIAL_SUPPLY);
        assertEq(token.balanceOf(owner), INITIAL_SUPPLY);
    }

    function test_CapIsCorrect() public {
        assertEq(token.cap(), MAX_SUPPLY);
    }

    function test_OwnerIsDeployer() public {
        assertEq(token.owner(), owner);
    }

    // -----------------------------
    // MINT
    // -----------------------------

    function test_OwnerCanMint() public {
        token.mint(user, 100_000 ether);

        assertEq(token.balanceOf(user), 100_000 ether);
    }

    function test_NonOwnerCannotMint() public {
        vm.prank(attacker);

        vm.expectRevert();
        token.mint(user, 100 ether);
    }

    function test_CannotExceedCap() public {
        uint256 remaining = MAX_SUPPLY - INITIAL_SUPPLY;

        token.mint(user, remaining);

        vm.expectRevert();
        token.mint(user, 1 ether);
    }

    // -----------------------------
    // BURN
    // -----------------------------

    function test_UserCanBurn() public {
        token.mint(user, 10_000 ether);

        vm.prank(user);
        token.burn(10_000 ether);

        assertEq(token.balanceOf(user), 0);
    }

    function test_BurnReducesTotalSupply() public {
        token.mint(user, 5_000 ether);

        vm.prank(user);
        token.burn(5_000 ether);

        assertEq(token.totalSupply(), INITIAL_SUPPLY);
    }

    function test_CannotBurnMoreThanBalance() public {
        vm.prank(user);

        vm.expectRevert();
        token.burn(1 ether);
    }

    // -----------------------------
    // EDGE CASES
    // -----------------------------

    function test_MintToZeroAddressReverts() public {
        vm.expectRevert();
        token.mint(address(0), 100 ether);
    }

    function test_MintZeroAmount() public {
        token.mint(user, 0);

        assertEq(token.balanceOf(user), 0);
    }

    function test_BurnZeroAmount() public {
        vm.prank(owner);
        token.burn(0);
    }
}
