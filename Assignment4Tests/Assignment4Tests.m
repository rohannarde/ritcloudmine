//
//  Assignment4Tests.m
//  Assignment4Tests
//
//  Created by rsn5770 on 10/3/12.
//  Copyright (c) 2012 rsn5770. All rights reserved.
//

#import "Assignment4Tests.h"
#import "InventoryStore.h"
#import "Item.h"

@implementation Assignment4Tests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

/**
 This function checks the properties of the Item class
 
 @param none
 @return none
 */
-(void)testItemProperties
{
    Item *item = [[Item alloc] init];
    
    NSString *itemName = item.itemName;
    NSDate *date = item.lastInventoryDate;
    NSInteger quanity = item.currentQuantity;
    CGFloat unitCost = item.unitCost;
    
    item.itemName = itemName;
    item.currentQuantity = quanity;
    item.unitCost = unitCost;
    item.lastInventoryDate = date;
    
}

/**
 This function tests properties of the Inventory class
 
 @param none
 @return none
 */
- (void)testInventoryProperties {
    Inventory *inventory = [[Inventory alloc] initWithName:@"Inventory1"];
    
    NSString *name = [inventory inventoryName];
    NSLog(@"Name; %@", name);
    
    inventory.inventoryName = @"Inventory1";
    inventory.lastModified = [NSDate date];
    inventory.isModified = YES;
}

/**
 This function removes files from the defaul directory for testing
 @param - none
 @return - none
 */
- (void)removeFilesFromTheDefaulDirectory{
    
   /**
    NSError *error;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *path = [InventoryStore inventoryStorePath];
    NSArray *dirContents = [fm contentsOfDirectoryAtPath:path error:&error];
    NSArray *plistFiles = [dirContents filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.plist'"]];
        
    for (NSString *pathE in plistFiles) {
        NSString *fullPath = [path stringByAppendingPathComponent:pathE];
        [fm removeItemAtPath:fullPath error:&error];
    }
    */
}


/**
Helper Function to give the count of the plist files in default directory
 @param - none
 @return - none
 */
- (NSInteger)givePListFileCount{
    /**
    NSError *error;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *path = [InventoryStore inventoryStorePath];
    NSArray *dirContents = [fm contentsOfDirectoryAtPath:path error:&error];
    NSArray *plistFiles = [dirContents filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.plist'"]];
    
    return [plistFiles count];
    
     */
    return 1;
}

/**
 This function will check the file functions 
 [setShared] - sets the Inventory setshared function
 [saveShared] - checks whether the function saves the inventories in plist
 [check is modified before and after saveShared] - checks if the isModified is changed after the saveShared is called
 [loadShared] - Checks whether the fucntion loadShared loads the inventory from file default loacation
 @param none
 @return none
 */
-(void)testFileFunctions

{
    //Removing files before testing from the default folder
    [self removeFilesFromTheDefaulDirectory];
     
    InventoryStore *store = [[InventoryStore alloc] init];
    
    [InventoryStore setShared:store]; 
    
    InventoryStore *testStore = [InventoryStore shared];
    
    // Testing setShared and shared
    STAssertTrue([store count] == [testStore count], @"Checks whether count in both stores are equal");
    
    for(int i = 0; i< [store count] ;i++){
        
        Inventory *inventoryOne = [store inventoryAtIndex:i];
        Inventory *inventoryTwo = [testStore inventoryAtIndex:i];
        STAssertTrue([inventoryOne isEqual: inventoryTwo], @"Checks individual inventory objects");
        
        for(int j = 0; j< [[store inventoryAtIndex:i] count] ;j++){
            Item* itemOne = [inventoryOne itemAtIndex:j];
            Item* itemTwo = [inventoryTwo itemAtIndex:j];
            STAssertTrue([ itemOne isEqual:itemTwo ], @"Checks the individual items of each inventory");
        }
    }
    
    //Removing files before testing from the default folder
    [self removeFilesFromTheDefaulDirectory];
    [[InventoryStore shared]removeAll];
    
    int modifiedInventoryCountBefore = 0;
    int modifiedInventoryCountAfter = 0;
    
    
    //Check total modified inventories before shared
    InventoryStore *testInventoryStore = [InventoryStore shared];
    Inventory *inventoryOne = [[Inventory alloc] initWithName:@"Inventory 1"];
    Inventory *inventoryTwo = [[Inventory alloc] initWithName:@"Inventory 2"];
    Inventory *inventoryThree = [[Inventory alloc] initWithName:@"Inventory 3"];
    
    [testInventoryStore addInventory:inventoryOne];
    [testInventoryStore addInventory:inventoryTwo];
    [testInventoryStore addInventory:inventoryThree];
     
    int actualModifiedInventoryCountBefore = 3;
    int actualModifiedInventoryCountAfter = 0;
    
    //Calculates the number of modified inventories before saveShared 
    for( int i = 0 ; i< [testInventoryStore count] ;i++){
        
        
        if([[testInventoryStore inventoryAtIndex:i]isModified]){
            
            modifiedInventoryCountBefore++;
        }
        
    }
    
    [InventoryStore saveShared];
    
    //Calculates the number of modified inventories after saveShared
    for( int i =0 ; i < [testInventoryStore count] ;i++){
        
        if([[testInventoryStore inventoryAtIndex:i]isModified]){
            
            modifiedInventoryCountAfter++;
        }
        
    }
    
    //Checks the isModified count before and after the inventories have been saved to the directory 
    STAssertTrue((actualModifiedInventoryCountBefore == modifiedInventoryCountBefore), @"Checks if inventory isModified is changed");
    STAssertTrue((actualModifiedInventoryCountAfter == modifiedInventoryCountAfter), @"Checks if inventory isModified is changed");
    
    
    //Removing files before testing the saveShared function
    [self removeFilesFromTheDefaulDirectory];
    [[InventoryStore shared] removeAll];
    
    int fileCountBefore = [self givePListFileCount];
    int actualFileCountBefore = 0;
    

    
    inventoryOne = [[Inventory alloc] initWithName:@"Inventory"];

    [[InventoryStore shared] addInventory:inventoryOne];
    [InventoryStore saveShared];
   
    STAssertTrue([InventoryStore saveShared], @"Checks if inventory has been saved in file");
    
    
    
    int fileCountAfter = [self givePListFileCount];
    int actualFileCountAfter = 1;
    
    //Checking the files stored properly in the default location or not by checking the number of pList files before and after the saveShared
    STAssertTrue(fileCountBefore == actualFileCountBefore, @"Check whether the files have been saved");
    STAssertTrue(fileCountAfter == actualFileCountAfter, @"Check whether the files have been saved");
   

    //LoadShared function is tested
    [[InventoryStore shared] removeAll];
    
        
    int inventoryCountBefore = [[InventoryStore shared] count];
    int actualInventoryCountBefore = 0;
    
    [InventoryStore loadShared];
    
    int actualInventoryCountAfter = 1;
    int inventoryCountAfter =[ [InventoryStore shared]count];
    
    
    //Checks whether the fucntion loadShared loads the inventory from file default loacation
    STAssertTrue(actualInventoryCountBefore == inventoryCountBefore, @"Checks whether the count  ");
    STAssertTrue(actualInventoryCountAfter == inventoryCountAfter, @"Checks whether the loadShared function loads the inventory");
    
    
}

/**
 This function will test the following functions from InventoryStore class
 - init 
 - addInventory:(Inventory*) atIndex:(NSUInteger)( Boundary Conditions )
 - addInventory:(Inventory*)
 - count
 
 @param none
 @return none
 */
- (void)testAddInventoryPartOne
{
    
    //Testing init for Inventory
    Inventory *spareParts = [[Inventory alloc]initWithName:@"spareParts"];
    InventoryStore *inventoryStore = [[InventoryStore alloc] init];
    STAssertNotNil(spareParts, @"Checking for null inventory store");
    
    //Testing boundary condition for inventoryStore
    [inventoryStore addInventory:spareParts atIndex:0];
    Inventory *checkBoundInventory = [inventoryStore inventoryAtIndex:100];
    STAssertNil (checkBoundInventory, @"Checks for null inventory object");

     Inventory *carSpareParts = [[Inventory alloc]initWithName:@"carSpareParts"];
     inventoryStore = [[InventoryStore alloc] init];
    
    // Testing init for inventoryStore
    STAssertNotNil(inventoryStore, @"Checking for null inventory store");
    
    // Testing boundary condition for function addInventory atIndex
    [inventoryStore addInventory:carSpareParts atIndex:0];
    checkBoundInventory = [inventoryStore inventoryAtIndex:0];
    STAssertNotNil (checkBoundInventory, @"Checks for not null inventory object");
    
    // Testing function addInventory and count
    Inventory *actualInventoryObject = [[Inventory alloc]initWithName:@"Inventory2"];
    [inventoryStore addInventory:actualInventoryObject];
    STAssertTrue(([inventoryStore count] == 2),@"Checks if there are 2 objects in the store");
}

/**
 This function will test the following functions of InventoryStore
 - addInventory:(Inventory*) AtIndex:(NSUInteger)( Boundary Conditions )
 - count
 - removeInventory:(Inventory*)
 - removeInventory:(Inventory*)atIndex:(NSUInteger)( Boundary Conditions )
 - addInventory:(Inventory*) atIndex:(NSUInteger)( Boundary Conditions )
 - removeAll
 
 @param none
 @return none
 */
-(void)testRemoveFunctions
{
    
    Inventory *headphones = [[Inventory alloc]initWithName:@"headphones"];
    Inventory *travelCase = [[Inventory alloc]initWithName:@"travelCase"];
    InventoryStore *inventoryStore = [[InventoryStore alloc] init];
    
    //Testing addInventory atIndex
    [inventoryStore addInventory:headphones atIndex:0];
    STAssertTrue(([inventoryStore count] == 1), @"This will check if object was added and size increases by one");
    
    
    //Testing addInventory atIndex
    [inventoryStore addInventory:travelCase atIndex:1];
    STAssertTrue(([inventoryStore count] == 2), @"This will check if this object was added and size increases by 1");
    
    //Testing boundary condition for addInventory atIndex
    [inventoryStore addInventory:travelCase atIndex:103];
    STAssertTrue(([inventoryStore count] == 2), @"This will show that the request was ignored and the store is left unchanged");
    
    
    // Testing boundary conditon for removeInventory atIndex
    [inventoryStore removeInventoryAtIndex:101];
    STAssertTrue(([inventoryStore count] == 2), @"This will show that the request was ignored and the store is left unchanged");
    
    
    // Testing removeInventory
    // Removing the second inventory obj    ect
    [inventoryStore removeInventory:travelCase];
    STAssertTrue(([inventoryStore count] == 1), @"This will check if object was removed");
    
    
    // Testing removeInventory atIndex
    // Removing the first inventory
    [inventoryStore removeInventoryAtIndex:0];
    STAssertTrue(([inventoryStore count] == 0), @"This will check if object was removed");
    
    
    // Testing addInventory atIndex
    [inventoryStore addInventory:headphones atIndex:0];
    STAssertTrue(([inventoryStore count] == 1), @"This will check if object was added");
    
    
    // testing removeAll fior InventoryStore
    [inventoryStore removeAll];
    STAssertTrue(([inventoryStore count] == 0), @"This will check if store was emptied");;

}

/**
 This function will test the following functions of Inventory class
 - totalCost
 - totalItems
 - addItem:(Item*) atIndex(NSUInteger)( Boundary Conditions )
 - addItem:(Item*)
 - itemAtIndex:(NSUInteger)( Boundary Conditions )
 - count
 - removeItem:(Item*)
 - removeItemAtIndex:(NSUInteger)( Boundary Conditions )
 - removeAll
 
 @param none
 @return none
 */
-(void) testInventoryFunctions
{
    Inventory *spareParts = [[Inventory alloc]initWithName:@"Inventory1"];
    NSDate *date = [[NSDate alloc ] init];
    
    Item *bolt  = [[Item alloc]initWithDetails:@"bolt" currentQuantity:1 inventoryDate:date unitCost:0.03];
    Item *screw  = [[Item alloc]initWithDetails:@"screw" currentQuantity:1 inventoryDate:date unitCost:0.03];
    
    // Adding two items using AddItemAtIndex and addItem
    [spareParts addItem:bolt atIndex:55];
    STAssertTrue(([spareParts count] == 0), @"Will confirm that the size of the Inventory remains unchanged and the request is ignored");
    
    // Adding two items
    [spareParts addItem:screw];
    [spareParts addItem:bolt atIndex:0];
    
    // TEsting removeAll
    int actualSize = 0;
    [spareParts removeAll];
    int expectedSize = [spareParts count];
    STAssertTrue((actualSize == expectedSize), @"Checking removeAll function");
    
    // Testing addItem for Inventory
    // Testing addItem atIndex for Inventory
    [spareParts addItem:bolt atIndex:0];
    [spareParts addItem:screw];
    STAssertTrue(([spareParts count] == 2), @"Checks if item was added");
    
    
    //Testing totalCost
    float actualTotalCost = bolt.unitCost + screw.unitCost;
    float expectedTotalCost = [spareParts totalCost];
    STAssertTrue((actualTotalCost == expectedTotalCost ), @"Checks for expected and actual totalCost for inventory");
    
   

    // Testing totalItems
    int actualTotalItems = 2;
    int expectedTotalItems = [spareParts totalItems];
    STAssertTrue(expectedTotalItems == actualTotalItems, @"Checks for expected and actual totalItems in inventory");
    
    
    // Testing itemAtIndex
    Item* expectedActualItem = [spareParts itemAtIndex:0];
    STAssertTrue([expectedActualItem isEqual: bolt], @"This will check isEqual as well as itemAtIndex");
    
    
    // Testing boundary condition for itemAtIndex
    Item* expectedNullItem = [spareParts itemAtIndex:33];
    STAssertNil(expectedNullItem, @"This will confirm that the there are no objects and the request is ignored");
    
    // Testing boundary condition for removeItem atIndex
    expectedSize = 2;
    [spareParts removeItemAtIndex:88];
    actualSize = [spareParts count];
    STAssertTrue((expectedSize == actualSize), @"Will check the size of the inventory after removing an item");
    
    // Testing removeItemAtIndex
    [spareParts removeItemAtIndex:0];
    expectedSize = 1;
    actualSize = [spareParts count];
    STAssertTrue((expectedSize == actualSize), @"Will check the size of the inventory after removing an item");
    
    
    // Testing removeItem
    expectedSize = 0;
    [spareParts removeItem:screw];
    actualSize = [spareParts count];
    STAssertTrue((actualSize == expectedSize), @"testing removeItem function");
    
};
@end
