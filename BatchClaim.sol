// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

// Contracts for batch airdrop of ERC20 tokens.
// Only for contracts that are not checked for EOA.
interface Claim {
    function balanceOf(address account) external view returns(uint256);
    function transfer(address recipient, uint256 amount) external;
}

contract CallAirdrop {
    /**
     * @param target Address of the target contract.
     * @param data  `data` is the signature of the function to be executed by the call.
     */
    constructor(address target, bytes memory data) {
        require(target != address(0));
        (bool success, ) = target.call(data);
        require(success);

        uint256 balance = Claim(target).balanceOf(address(this));
        require(balance > 0);
        
        Claim(target).transfer(tx.origin, balance);
        selfdestruct(payable(address(msg.sender)));
    }
}

contract MultiCall {
    function operator(address target, uint256 times, bytes calldata data) external {
        for (uint i = 0; i <= times; ++i) {
            new CallAirdrop(target, data);
        }
    }
}
