//
//  CompanyInventoryViewController.h
//  Assignment 5
//
//  Created by
//  Rohan Narde - rsn5770@rit.edu
//  Amit Shroff - aas6521@rit.edu
//  on 9/22/12.
//  Copyright (c) 2012 Rohan Narde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CloudMine/CloudMine.h>

@class AddInventoryViewController;
@class InventoryViewController;
@class InventoryStore;

/**
    This interface is the table view of all the Inventory Store's in the application.
 */
@interface CompanyInventoryViewController : UITableViewController <UITableViewDataSource>
{
    AddInventoryViewController *_addInventoryViewController;
    InventoryViewController *_inventoryViewController;
    InventoryStore *_storeObject;
    CMUser *_user;
}

// The function that calls the add new inventory store modal view.
-(IBAction)addInventory:(id)sender;

/**
 This function logs the user out and displays the AddInventoryViewController
 */
-(IBAction) implementLogout:(id)sender;

@property (nonatomic) CMUser *user;
@property (nonatomic)  NSMutableArray *companyInventoryListArray;
@property (nonatomic) UIImage *image;

@end
