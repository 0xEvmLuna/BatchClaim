pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// example 
contract GLDToken is ERC20 {
    
    uint claim_nums = 10;
    uint public MAX_SUPPLY = 100000;
    mapping (address => bool) private _claimed;
    
    constructor() ERC20("Gold", "GLD") {
    }


    function claim() public {
        require(totalSupply() + claim_nums <= MAX_SUPPLY);
        require(!_claimed[msg.sender], "The account had claimed token.");

        // Checks-Effects-Interactions
        _claimed[msg.sender] = true;
        _mint(msg.sender, claim_nums);
    }
}
