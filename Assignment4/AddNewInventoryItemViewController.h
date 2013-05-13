//
//  AddNewInventoryItemViewController.h
//  Assignment 5
//
//  Created by
//  Rohan Narde - rsn5770@rit.edu
//  Amit Shroff - aas6521@rit.edu
//  on 9/22/12.
//  Copyright (c) 2012 Rohan Narde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import "Inventory.h"
#import "InventoryStore.h"



/**
 This is the interface used to display the model view controller to add a new Inventory Item
 */
@interface AddNewInventoryItemViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UITextField *itemNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *itemQuantityTextField;
@property (weak, nonatomic) IBOutlet UITextField *itemUnitCostTextField;
@property (nonatomic,assign) NSInteger currentSelectedInventoryIndex;


/**
 This function defines the functionality of the create button
 It will create an InventoryItem if name is not null
 @param id
 @return none
 */
- (IBAction)createLeftBarButton:(id)sender;

/**
 This function defines the functionality of the cancel button
 It will dismiss the modal view controller 
 @param id
 @return none
 */
- (IBAction)cancelRightBarButton:(id)sender;

@end
