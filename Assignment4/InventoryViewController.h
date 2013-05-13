//
//  InventoryViewController.h
//  Assignment 5
//
//  Created by
//  Rohan Narde - rsn5770@rit.edu
//  Amit Shroff - aas6521@rit.edu
//  on 9/22/12.
//  Copyright (c) 2012 Rohan Narde. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddNewInventoryItemViewController;
@class ItemTableViewController;
@class Inventory;
/**
 * @author Rohan Narde
 *          Amit Shroff
 * This is the ItemViewController which gives the user the functionality to view a Item
 * to add a new random item and also to update the item contents
 *
 */
@interface InventoryViewController : UITableViewController {
    

    ItemTableViewController *_itemTableViewController;
    AddNewInventoryItemViewController *_newItemViewController;
    Inventory *_currentSelectedInventory;
    UISwipeGestureRecognizer *_swipeRecognizer;
    }

/**
 This function adds a random item from the randomTestDataArray to the Inventory List
 @param : id
 @return : IBAction
 */
-(IBAction)addNewItem:(id)sender;


@property (nonatomic,assign) NSInteger currentSelectedInventoryIndex;

@end
