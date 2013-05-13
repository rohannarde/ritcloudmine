//
//  InventoryStore.m
//  Assignment 5
//
//  Created by
//  Rohan Narde - rsn5770@rit.edu
//  Amit Shroff - aas6521@rit.edu
//  on 9/22/12.
//  Copyright (c) 2012 Rohan Narde. All rights reserved.
//

#import "InventoryStore.h"
#import "CompanyInventoryViewController.h"
#import "Item.h"

static InventoryStore *sharedInventoryStore;
static NSString * const kDirectoryInventory = @"Inventory";

@implementation InventoryStore
@synthesize isTestFailureMode;

+ (InventoryStore *)shared{
    
    if(!sharedInventoryStore){
        sharedInventoryStore = [[InventoryStore alloc]init];
    }
    
    return sharedInventoryStore;
    
}


+ (void)setShared:(InventoryStore *)inventoryStore{
    
    sharedInventoryStore = inventoryStore;
    
}


+ (BOOL)saveShared{
    
    
    BOOL returnStatement = YES;
    
    CMStore *store = [CMStore defaultStore];
    InventoryStore *saveStore = [InventoryStore shared];
    
    //Checks the store, if it is 0 there is nothing to save
    if([saveStore count] == 0){
        
        returnStatement = NO;
        
    }
    
    
    for(int i=0 ; i < [saveStore count]; i++){
        
        Inventory *saveInventory = [saveStore inventoryAtIndex:i];
        
        if(saveInventory.isModified==YES){
            
            saveInventory.isModified= NO;
            
            NSMutableArray *uniqueID = [[NSMutableArray alloc]init];
            [uniqueID addObjectsFromArray:[saveInventory getItemIdentifierArray]];
            
            for(int i =0 ;i <[uniqueID count] ;i++){
                Item *saveItem = [saveInventory itemAtIndex:i];
                [saveItem saveWithUser:store.user callback:^(CMObjectUploadResponse *response) {
                    
                    if (![[response.uploadStatuses objectForKey:saveItem.objectId] isEqualToString:@"created"])
                    {
                        if(![[response.uploadStatuses objectForKey:saveItem.objectId] isEqualToString:@"updated"])
                        {
                            NSString *message = @"The item could not be created.";
                            if (response.error)
                                message = [response.error localizedDescription];
                            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:[response.error localizedDescription] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                            [errorAlert show];
                        }
                    }
                    
                }];
                
                
                
                
            }
            [saveInventory setItemIdentifierArray:uniqueID];
            
            [saveInventory saveWithUser:store.user callback:^(CMObjectUploadResponse *response)
             {
                 if (![[response.uploadStatuses objectForKey:saveInventory.objectId] isEqualToString:@"created"])
                 {
                     if(![[response.uploadStatuses objectForKey:saveInventory.objectId] isEqualToString:@"updated"])
                     {
                         NSString *message = @"The item could not be created.";
                         if (response.error)
                             message = [response.error localizedDescription];
                         UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:[response.error localizedDescription] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                         [errorAlert show];
                     }
                 }
                 
             }];
            
            
            
        }
        
    }
    
    return returnStatement;
}

+ (BOOL)loadShared{
    
    InventoryStore *loadStore = [InventoryStore shared];
    
    [loadStore removeAll];
    
    CMStore *store = [CMStore defaultStore];
    
    //Inventory grab from the CloudMine
    [store allUserObjectsOfClass:[Inventory class]
               additionalOptions:nil
                        callback:^(CMObjectFetchResponse *responseInventory) {
                            
                            // Alerting the user if any error occurred
                            if (responseInventory.error) {
                                
                                UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error fetching Inventory from CloudMine" message:[responseInventory.error localizedDescription] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                                [errorAlert show];
                            }
                            
                            // Replacing local items with those loaded from the server
                            if (responseInventory.objects.count) {
                                
                            }
                              NSMutableArray *inventoryArray = [[NSMutableArray alloc] initWithArray:responseInventory.objects];
                            
                                for (int i=0; i<inventoryArray.count; i++) {
                                    
                                    
                                    Inventory *loadInventory = [inventoryArray objectAtIndex:i];
                                    
                                    [loadStore addInventory:loadInventory];
                                    
                                    
                                    NSMutableArray *uniqueIDItems = [[NSMutableArray alloc]init];
                                    [uniqueIDItems addObjectsFromArray:[loadInventory getItemIdentifierArray]];
                                                   
                                    [[loadInventory getItemIdentifierArray] removeAllObjects];
                                    
                                    // NSLog(@"%d THAT %d",uniqueIDItems.count,loadInventory.itemIdentifierArray.count);
                                    
                                    if(uniqueIDItems.count){
                            
                                        
                                        
                                        //Item grab for particular inventory from CloudMine
                                        
                                        [store userObjectsWithKeys:uniqueIDItems
                                                 additionalOptions:nil
                                                          callback:^(CMObjectFetchResponse *responseItem) {
                                                
                                            
                                            // Alerting the user if any error occurred
                                            if (responseItem.error) {
                                                NSString *alertString = [[NSString alloc]initWithFormat:@"Error fetching Items for Inventory %@",loadInventory.inventoryName];
                                                UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:alertString message:[responseItem.error localizedDescription] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                                                [errorAlert show];
                                            }
                                            
                                            // Replacing local items with those loaded from the server
                                            if (responseItem.objects.count) {
                                                for (int j=0; j<responseItem.objects.count; j++) {
                                                   
                                                    
                                                    Item *loadItem = [responseItem.objects objectAtIndex:j];
                                                    [loadInventory addItem:loadItem];
                                                    
                                                }
                                            }
                                            [loadStore reloadCompanyInventoryViewControllerData];
                                        }];
                                        
                                    }
                                    
                                    
                                }
                            
                            
                            [loadStore reloadCompanyInventoryViewControllerData];
                            
                        }
     
     ];
    return YES;
}
- (id) init {
    self = [super init];
    if(self)
    {
        _inventoryStore = [[NSMutableArray alloc]init];
    }
    return self;
    
}

- (void)addInventory:(Inventory *)inventory{
    
    [_inventoryStore addObject:inventory];
    [InventoryStore saveShared];
    
}




- (void)addInventory:(Inventory *)inventory atIndex:(NSUInteger) index {

    if(index <= [_inventoryStore count]){
        [_inventoryStore insertObject:inventory atIndex:index];
        [InventoryStore saveShared];
        
    }
}



- (Inventory *)inventoryAtIndex:(NSUInteger)index{
    
    if([_inventoryStore count] > index){
        
        return [_inventoryStore objectAtIndex:index];
        
    }
    return nil;
    
}

- (void)removeInventoryAtIndex:(NSUInteger)index{
    
    if(index < [_inventoryStore count]){
    
    Inventory *inventoryToRemove = [_inventoryStore objectAtIndex:index];
    
    [_inventoryStore removeObjectAtIndex:index];
    // Update web service - delete if the web service confirms success, otherwise re-add it
    CMStore *store = [CMStore defaultStore];
    [store deleteUserObject:inventoryToRemove
     
      additionalOptions:nil
               callback:^(CMDeleteResponse *response) {
                   
                   //Check if the deletion was successful on Cloud
                   if (response.success.count < 1) {
                       
                       [_inventoryStore insertObject:inventoryToRemove atIndex:index];
                       
                       // Alert the user
                       NSString *message = [[NSString alloc]initWithFormat:@"The Inventory %@ could not be deleted.",inventoryToRemove.inventoryName];
                       if (response.error){
                           message = [response.error localizedDescription];
                       UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error Deleting" message:[response.error localizedDescription] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                       [errorAlert show];
                       }
                   }
                   
                   else{
                       
                       for(int i=0 ;i < [inventoryToRemove count];i++){
                           
                           [store deleteObject:[inventoryToRemove itemAtIndex:i] additionalOptions:nil callback:^(CMDeleteResponse *response) {
                               
                           }];
                       }
                   }
               }
        ];
    }
}

- (void)removeInventory:(Inventory *)inventory{
    //InventoryStore *inventoryStore = [InventoryStore shared];
    for(int i = 0; i < _inventoryStore.count; i++){
        
        Inventory *inventoryToRemove = [_inventoryStore objectAtIndex:i];
        
        if([inventoryToRemove isEqual: inventory]){
            
            [self removeInventoryAtIndex:i];
            
            break;
        }
    }
}

- (NSUInteger)count{
    
    return [_inventoryStore count];
}

- (void)removeAll{
  
    [_inventoryStore removeAllObjects];
    
}


- (void)setCompanyInventoryObject:(CompanyInventoryViewController *)companyInventoryObject{
    
    _companyInventoryObject = companyInventoryObject;
    
    
}


- (void)reloadCompanyInventoryViewControllerData{
    
    if(_companyInventoryObject){
    
        [_companyInventoryObject.tableView reloadData];
    
    }
}

@end
