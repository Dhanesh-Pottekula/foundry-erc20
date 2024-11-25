// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test,console} from "forge-std/Test.sol";
import {OurToken} from "../src/OurToken.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";

contract ourTokenTest is Test {
    OurToken ourToken;            // This will hold the deployed token contract
    DeployOurToken deployerOurToken; // This will handle the deployment

    address bob = makeAddr('bob');
    address alice = makeAddr('alice');

    uint256 public constant STARTING_BALANCE = 100 ether; // Token transfer amount

    // Setup the test by deploying the token and transferring tokens
    function setUp() public {
        // Deploy the token
        deployerOurToken = new DeployOurToken();
        ourToken = deployerOurToken.run();  // Call run to get the deployed token

        // Transfer starting balance to bob
        vm.prank(msg.sender); // Make deployer the sender

        ourToken.transfer(bob, STARTING_BALANCE); // Transfer 100 ether to bob
    }

    // Test that bob's balance is correctly set
    function testBobBalance() public {
        uint256 bobBalance = ourToken.balanceOf(bob);
        assertEq(bobBalance, STARTING_BALANCE, "Bob's balance should be the starting balance");
    }

    function testAllowence () public{
        uint256 initialAllowance =1000;
        console.log(alice);
        vm.prank(bob);
        ourToken.approve(alice,initialAllowance); 
        uint256 transferAmount=500;
        
        vm.prank(alice);
        ourToken.transferFrom(bob,alice,transferAmount);

        assertEq(ourToken.balanceOf(alice),transferAmount);
    }
   
   function testTransfer () public {
    uint256 amount =1000;
    vm.prank(bob);
    ourToken.transfer(alice,amount);

    assertEq (ourToken.balanceOf(alice),amount);
   }
}
