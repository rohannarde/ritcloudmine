//
//  ItemTableViewController.h
//  Assignment 5
//
//  Created by
//  Rohan Narde - rsn5770@rit.edu
//  Amit Shroff - aas6521@rit.edu
//  on 9/22/12.
//  Copyright (c) 2012 Rohan Narde. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Item;


/**
 This controller gives the functionality to the user to update the contents of the Item
 */
@interface ItemTableViewController : UIViewController <UITextFieldDelegate> {
    
    Item *_currentSelectedItem;
}

@property (weak, nonatomic) IBOutlet UITextField *itemNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *currentQuantityTextField;
@property (weak, nonatomic) IBOutlet UITextField *unitCostTextField;
@property (weak, nonatomic) IBOutlet UITextField *inventoryDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *addQuantityTextField;
@property (nonatomic,assign) NSInteger currentSelectedInventoryIndex;
@property (nonatomic,assign) NSInteger currentSelectedItemIndex;

/**
 This function updates the current quantity with the quantity specified by the user
 @param : id
 @return : IBAction
 */
- (IBAction)addQuantityButton:(id)sender;

@end
