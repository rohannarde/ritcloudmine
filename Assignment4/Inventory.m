//
//  Inventory.m
//  Assignment 4
//
//  Created by
//  Rohan Narde - rsn5770@rit.edu
//  Amit Shroff - aas6521@rit.edu
//  on 9/22/12.
//  Copyright (c) 2012 Rohan Narde. All rights reserved.
//
#import "Inventory.h"
#import "Item.h"
#import "InventoryStore.h"
#import <CloudMine/CloudMine.h>

static NSString * const kInventoryName = @"inventoryName";
static NSString * const kItemArray = @"itemIdentifierArray";
static NSString * const kLastModified = @"lastModified";

@implementation Inventory
@synthesize inventoryName;
@synthesize isModified;



- (void) encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:inventoryName forKey:kInventoryName];
    [aCoder encodeObject:_itemIdentifierArray forKey:kItemArray];
    [aCoder encodeObject:_lastModified forKey:kLastModified];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if(self){
        
         [self setInventoryName:[aDecoder decodeObjectForKey:kInventoryName]];
          [self setItemIdentifierArray:[aDecoder decodeObjectForKey:kItemArray]];
        _lastModified = [aDecoder decodeObjectForKey:kLastModified];
        
        if(!_itemStore){
            
            _itemStore = [[NSMutableArray alloc]init];            
        }
        
    }
    
    return self;
}


- (id) initWithName:(NSString *)inventoryNameVal {
    
    self = [super init];
    if(self) {
        
        _itemStore = [[NSMutableArray alloc]init];
        _itemIdentifierArray = [[NSMutableArray alloc]init];
        inventoryName = inventoryNameVal;
        _lastModified = [NSDate date];
        isModified = YES;
        
    }
    return self;
}

- (CGFloat)totalCost{
    
    float totalCost = 0;
    
    for(Item *tempItem in _itemStore){
        
        totalCost += (tempItem.unitCost * tempItem.currentQuantity);
        
    }
    return totalCost;
}

- (NSInteger)totalItems{
    
    NSInteger totalItems = 0;
    
    for(Item *tempItem in _itemStore){
        
        totalItems += tempItem.currentQuantity;
        
    }
    return totalItems;
}

- (void) addItem:(Item *)item{
    
    [_itemStore addObject:item];
    [_itemIdentifierArray addObject:item.objectId];
    [self changeIsModified:YES];
    [InventoryStore saveShared];
    
    
    
    
}



- (void) addItem:(Item *)item atIndex:(NSUInteger)index{
    
    if(index <= [_itemStore count]){
        
        [_itemStore insertObject:item atIndex:index];
        [_itemIdentifierArray insertObject:item.objectId atIndex:index];
        [self changeIsModified:YES];
        [InventoryStore saveShared];
        
    }
}

- (Item *)itemAtIndex:(NSUInteger)index{
    
    if(index < [_itemStore count])
        return [_itemStore objectAtIndex:index];
    else
        return nil;
}

- (NSUInteger)count {
    
    return [_itemStore count];
    
}

- (NSUInteger)itemIdentifierCount{
    
    return [_itemIdentifierArray count];
}

- (void) removeItem:(Item *)item{
    
    for(int i = 0; i < _itemStore.count; i++){
        
        Item *itemToRemove = [_itemStore objectAtIndex:i];
        
        if([itemToRemove isEqual: item]){
            
            [self removeItemAtIndex:i];
            
            break;
        }
    }
    
}

- (void) removeItemAtIndex:(NSInteger)index{
    
    if(index < [_itemStore count]){
        
        [_itemStore removeObjectAtIndex:index];
        [_itemIdentifierArray removeObjectAtIndex:index];
        [self changeIsModified:YES];
        [InventoryStore saveShared];
    }
    
}

- (void) removeAll{
    
    [_itemStore removeAllObjects];
    [_itemIdentifierArray removeAllObjects];
    [self changeIsModified:YES];
    
}
- (void)changeIsModified:(BOOL)changeTo {
    
    isModified = changeTo;
    if(changeTo == YES){
        _lastModified = [NSDate date];
    }
    
}

#pragma mark - Overloading the isEqual function for Inventory class
-(BOOL)isEqual:(id)other{
    
    if(other == self)
        return YES;
    if(!other || ![other isKindOfClass:[self class]])
        return NO;
    return [self isEqualToSample:other];
}


-(BOOL)isEqualToSample:(Inventory *) other{
    
    if(self == other)
        return YES;
    
    if (!([[self inventoryName] isEqualToString: [other inventoryName]]))
        return NO;
    
    if (!([self totalCost] == [other totalCost]))
        return NO;
    
    if (!([self totalItems] == [other totalItems]))
        return NO;
    
    return YES;
}

- (void) setItemIdentifierArray:(NSMutableArray *)itemIdentifierArray{
    
    _itemIdentifierArray = itemIdentifierArray;
    
}

- (NSMutableArray *) getItemIdentifierArray {
    
    return _itemIdentifierArray;
}

@end
