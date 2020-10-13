// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

import "eth-token-recover/contracts/TokenRecover.sol";

/**
 * @title ServiceReceiver
 * @author ERC20 Generator (https://vittominacori.github.io/erc20-generator)
 * @dev Implementation of the ServiceReceiver
 */
contract ServiceReceiver is TokenRecover {

    mapping (bytes32 => uint256) private _prices;

    function pay(string memory serviceName) public payable {
        require(msg.value == _prices[_toBytes32(serviceName)], "ServiceReceiver: incorrect price");
    }

    function getPrice(string memory serviceName) public view returns (uint256) {
        return _prices[_toBytes32(serviceName)];
    }

    function setPrice(string memory serviceName, uint256 amount) public onlyOwner {
        _prices[_toBytes32(serviceName)] = amount;
    }

    function withdraw(uint256 amount) public onlyOwner {
        payable(owner()).transfer(amount);
    }

    function _toBytes32(string memory serviceName) private pure returns (bytes32) {
        return keccak256(abi.encode(serviceName));
    }
}
