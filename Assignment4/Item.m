//
//  Item.m
//  Assignment 5
//
//  Created by
//  Rohan Narde - rsn5770@rit.edu
//  Amit Shroff - aas6521@rit.edu
//  on 9/22/12.
//  Copyright (c) 2012 Rohan Narde. All rights reserved.
//
#import "Item.h"


static NSString * const kItemName = @"itemName";
static NSString * const kCurrentQuantity = @"currentQuantity";
static NSString * const kLastInventoryDate = @"lastInventoryDate";
static NSString * const kUnitCost = @"unitCost";

@implementation Item

@synthesize itemName, lastInventoryDate,currentQuantity, unitCost;

//Item model Initializer
-(id)initWithDetails:(NSString *) itemNameVal currentQuantity:(NSInteger) currQuantVal inventoryDate:(NSDate *)lastInventDateVal unitCost:(float) unitCostVal{
   
    self = [super init];
    
    if(self){
    lastInventoryDate = lastInventDateVal;
    currentQuantity = currQuantVal;
    itemName = itemNameVal;
    unitCost = unitCostVal;
    
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
   
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:itemName forKey:kItemName];
    [aCoder encodeInt:currentQuantity forKey:kCurrentQuantity];
    [aCoder encodeObject:lastInventoryDate forKey:kLastInventoryDate];
    [aCoder encodeFloat:unitCost forKey:kUnitCost];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if(self){
        
        [self setItemName:[aDecoder decodeObjectForKey:kItemName]];
        [self setCurrentQuantity:[aDecoder decodeIntegerForKey:kCurrentQuantity]];
        [self setLastInventoryDate:[aDecoder decodeObjectForKey:kLastInventoryDate]];
        [self setUnitCost:[aDecoder decodeFloatForKey:kUnitCost]];
        
    }
    
    return self;
}

#pragma mark - Overloading the isEqual function for Item class

-(BOOL)isEqual:(id)other{
    
    if(other == self)
        return YES;
    if(!other || ![other isKindOfClass:[self class]])
        return NO;
    return [self isEqualToSample:other];
}


-(BOOL)isEqualToSample:(Item *) other{
    if(self == other)
        return YES;
       
    if (!([[self itemName] isEqualToString: [other itemName]]))
        return NO;
    
    if (!([[self lastInventoryDate] isEqualToDate: [other lastInventoryDate]]))
        return NO;
    if (!([self unitCost] == [other unitCost]))
        return NO;
    if (!([self currentQuantity] ==[other currentQuantity]))
        return NO;
    
    //if (!([self lastInventoryDate] ==[other lastInventoryDate]))
    //return NO;
    return YES;
}






@end
