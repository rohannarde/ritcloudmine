//
//  Item.h
//  Assignment 5
//
//  Created by
//  Rohan Narde - rsn5770@rit.edu
//  Amit Shroff - aas6521@rit.edu
//  on 9/22/12.
//  Copyright (c) 2012 Rohan Narde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CloudMine/CloudMine.h>

/**
 This interface is the model for the entries in the application
 */
@interface Item : CMObject{
    
}

@property (copy,nonatomic) NSString *itemName;
@property (nonatomic) NSInteger currentQuantity;
@property (nonatomic) float unitCost;
@property (strong,nonatomic) NSDate *lastInventoryDate;

/**
 Constructor for initializing an Item in the table view
 @param : NSString *itemName
 @param : NSInteger currentQuantity
 @param : NSDate *lastInventDate
 @param : float unitCost
 @return : id
 */
-(id)initWithDetails:(NSString *) itemNameVal currentQuantity:(NSInteger) currQuantVal inventoryDate:(NSDate *)lastInventDateVal unitCost:(float) unitCostVal;
@end
