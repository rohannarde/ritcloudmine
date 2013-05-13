//
//  Inventory.h
//  Assignment 4
//
//  Created by
//  Rohan Narde - rsn5770@rit.edu
//  Amit Shroff - aas6521@rit.edu
//  on 9/22/12.
//  Copyright (c) 2012 Rohan Narde. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CloudMine/CloudMine.h>

@class Item;

@interface Inventory : CMObject {
    
    NSMutableArray *_itemStore;
    NSMutableArray *_itemIdentifierArray;
}


@property (nonatomic, copy) NSString *inventoryName;
@property (nonatomic, strong) NSDate *lastModified;
@property (nonatomic, assign) BOOL isModified;


/**
 Initialize object with inventory name
 @param inventoryNameVal - The name of the inventory
 @return id - the object with which it is initialized i.e. self
 */
- (id) initWithName:(NSString *)inventoryNameVal;

/** Calculate the value of the entire inventory.
 @return a cost in dollars
 */
- (CGFloat)totalCost;

/** Calculate the total number of loose parts in the inventory. Sum all the parts for each item.
 @return the number of units in the entire inventory
 */
- (NSInteger)totalItems;

/** Append an item to the end of the list of items.
 @param item - the object to add
 */
- (void)addItem:(Item *)item;

/** Add an item to a specific index. If the index is not valid, do not add the item to the inventory.
 @param item - the item to add
 @param index - the index within the bounds of the current inventory item count
 */
- (void)addItem:(Item *)item atIndex:(NSUInteger)index;

/** Access the item at a given index.
 @return an Item if in bounds, otherwise nil
 */
- (Item *)itemAtIndex:(NSUInteger)index;

/** Retrieves the total number of items in the inventory.
 @return number of items
 */
- (NSUInteger)count;

/** Retrieves the total number of items in the itemIdentifierArray.
 @return number of items
 */
- (NSUInteger)itemIdentifierCount;

/** Removes the first item that matches from the Inventory. If there are duplicates, only the first in the list is removed. If no match is found vis isEqual, then it does not remove anything.
 @param item - the item to remove
 */
- (void)removeItem:(Item *)item;

/** Remove an item from a specific index. If the index is invalid, nothing happens.
 @param index - the index of an item to remove
 */
- (void)removeItemAtIndex:(NSInteger)index;

/** Remove all the Items in the inventory. */
- (void)removeAll;

- (void) changeIsModified:(BOOL)changeTo;
- (void) setItemIdentifierArray:(NSMutableArray *)itemIdentifierArray;
- (NSMutableArray *) getItemIdentifierArray;



@end
