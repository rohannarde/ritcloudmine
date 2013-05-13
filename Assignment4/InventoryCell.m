//
//  InventoryCell.m
//  Assignment 5
//
//  Created by
//  Rohan Narde - rsn5770@rit.edu
//  Amit Shroff - aas6521@rit.edu
//  on 9/22/12.
//  Copyright (c) 2012 Rohan Narde. All rights reserved.
//
#import "InventoryCell.h"


@implementation InventoryCell
@synthesize inventoryNameLabel;
@synthesize totalCostLabel;
@synthesize totalItemsLabel;
@synthesize modifiedDateLabel;
@synthesize inventoryImage;

// Constructor
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

// setSelected
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
