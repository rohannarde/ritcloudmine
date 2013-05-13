//
//  InventoryStore.h
//  Assignment 5
//
//  Created by
//  Rohan Narde - rsn5770@rit.edu
//  Amit Shroff - aas6521@rit.edu
//  on 9/22/12.
//  Copyright (c) 2012 Rohan Narde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Inventory.h"


@class CompanyInventoryViewController;

/**
 This is the model class for the inventory store
 */
@interface InventoryStore : NSObject {
    
    NSMutableArray *_inventoryStore;
    CompanyInventoryViewController *_companyInventoryObject;

}


/** The shared singleton instance.
 @return a lazy loaded InventoryStore static object
 */
+ (InventoryStore *)shared;

/** A helper method to change the static singleton instance. This is required for unit testing to provide teardown and setup logic.
 @param inventoryStore - the new store object
 */
+ (void)setShared:(InventoryStore *)inventoryStore;

/** Save the shared instance (singleton) to a default location, inventoryStorePath. The method should create any file paths required to save it.
 @return YES if successful, NO otherwise
 */
+ (BOOL)saveShared;

/** Load the shared instance (singleton) from a default location, inventoryStorePath. It will replace any Inventory objects currently stored in the the InventoryStore.
 @return YES if successful, NO otherwise
 */
+ (BOOL)loadShared;

/** The default initializer to create an empty InventoryStore. No random objects are added. Save and load does not happen at initialization, to prevent side effects when testing.
 */
- (id)init;

/** Appends an inventory to the end of the list.
 @param inventory - the object to add
 */
- (void)addInventory:(Inventory *)inventory;

/** Adds an inventory object to the specific index in the list if the index is valid. If it is an invalid index, the request is ignored.
 @param inventory - the inventory object to add
 @param index - the index to store the inventory at
 */
- (void)addInventory:(Inventory *)inventory atIndex:(NSUInteger)index; 

/** Retrieves the Inventory at a specific index.
 @param index - the index in the list
 @return an Inventory object if in bounds, otherwise nil
 */
- (Inventory *)inventoryAtIndex:(NSUInteger)index;

/** Retrieves the number of Inventory objects in the store.
 @return number of Inventories
 */
- (NSUInteger)count;

/** Removes the first occurance of the inventory from the list. Only removes an inventory object that matches based on the isEqual method.
 *Note* Disk space should be cleaned up.
 @param inventory - the invenotry object to remove
 */
- (void)removeInventory:(Inventory *)inventory;

/** Remove the inventory object at a specific index. If the index is invalid, the request is ignored.
 *Note* Disk space should be cleaned up.
 @param index - the index in the list to remove
 */
- (void)removeInventoryAtIndex:(NSUInteger)index;

/** Remove all inventory objects from the InventoryStore.
 *Note* Disk space should be cleaned up.
 */
- (void)removeAll;

- (void)setCompanyInventoryObject:(CompanyInventoryViewController *)companyInventoryObject;


@property (nonatomic, assign) BOOL isTestFailureMode;

@end


