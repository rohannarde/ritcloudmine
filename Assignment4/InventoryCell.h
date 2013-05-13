//
//  InventoryCell.h
//  Assignment 5
//
//  Created by
//  Rohan Narde - rsn5770@rit.edu
//  Amit Shroff - aas6521@rit.edu
//  on 9/22/12.
//  Copyright (c) 2012 Rohan Narde. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 This is the interface for the custom cell for displaying the attributes of
 an inventory store
 */
@interface InventoryCell : UITableViewCell <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *inventoryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalItemsLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *modifiedDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *inventoryImage;


@end
