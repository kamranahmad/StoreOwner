// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

/**
 * @title StoreOwner by King
 * @dev Contract to manage a Store of ownerships all over the country
 */
contract StoreOwner {
    // Mapping to stores and owners
    mapping(address => Store[]) private stores;

    // Struct to represent a store
    struct Store {
        string state; // state where store is located
        string city; // city where store is located
        string street; // street on which store is located
        string streetNumber; // store street number
        uint numberOfOwners; // number of owners of this store
    }

    // Custom error for handling invalid store index
    error BadStoreIndex(uint256 index);

    /**
     * @dev Adds a new store to the list
     * @param _state The state where store is located
     * @param _city The city where store is located
     * @param _street The street where store is located
     * @param _streetNumber The state number on the street
     * @param _numberOfOwners The number of owners of the store
     */
    function addStore(string memory _state, string memory _city, string memory _street, string memory _streetNumber, uint _numberOfOwners) external {
        // Push a new store struct with the provided details to the stores list
        stores[msg.sender].push(Store(_state, _city, _street, _streetNumber, _numberOfOwners));
    }

    /**
     * @dev returns the array of stores
     * @return An array of `Store` structs
     */
    function getMyStore() external view returns (Store[] memory) {
        // Return the array of stores to caller
        return stores[msg.sender];
    }

    /**
     * @dev Retrieves a specific user's store
     * @param _user The address of the user
     * @return An array of `Store` structs
     */
    function getUserStore(address _user) external view returns (Store[] memory) {
        // Return the store of the specified user
        return stores[_user];
    }

    /**
     * @dev Updates a specific store in our list
     * @param _index The index of the store
     * @param _state The state where store is located
     * @param _city The city where store is located
     * @param _street The street where store is located
     * @param _streetNumber The state number on the street
     * @param _numberOfOwners The number of owners of the store
     */
    function updateStore(uint256 _index, string memory _state, string memory _city, string memory _street, string memory _streetNumber, uint _numberOfOwners) external {
        // Check if the provided index is valid
        if (_index >= stores[msg.sender].length) {
            revert BadStoreIndex({index: _index}); // Revert with custom error if the index is invalid
        }
        // Update the specified store with the new details
        stores[msg.sender][_index] = Store(_state, _city, _street, _streetNumber, _numberOfOwners);
    }

    /**
     * @dev Deletes all stores
    */
    function resetMyStores() external {
        // Delete all stores for caller
        delete stores[msg.sender];
    }
}
