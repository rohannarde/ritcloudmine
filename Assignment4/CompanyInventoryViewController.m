//
//  CompanyInventoryViewController.m
//  Assignment 5
//
//  Created by
//  Rohan Narde - rsn5770@rit.edu
//  Amit Shroff - aas6521@rit.edu
//  on 9/22/12.
//  Copyright (c) 2012 Rohan Narde. All rights reserved.
//

#import "CompanyInventoryViewController.h"
#import "InventoryCell.h"
#import "AddInventoryViewController.h"
#import "InventoryViewController.h"
#import "InventoryStore.h"

const float kTimerSeconds = 120;

@implementation CompanyInventoryViewController
@synthesize companyInventoryListArray;
@synthesize user;
@synthesize image;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _storeObject = [InventoryStore shared];
    [_storeObject setCompanyInventoryObject:self];
    
    [self setTitle:@"Inventory List"];
   
    // Adding the bar button
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addInventory:)];
    
    self.navigationItem.rightBarButtonItem = addBarButtonItem;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(implementLogout:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    


}


// The logout button
-(IBAction)implementLogout:(id)sender
{
    CMUser *currentUser = user;
    [currentUser logoutWithCallback:^(CMUserAccountResult resultCode, NSArray *messages) {
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - functions used to implement swipe-to-delete
-(void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_storeObject removeInventoryAtIndex:indexPath.row];
    }
    [tableView reloadData];
}

/**
 This function loads the modal view controller for adding a new inventory store
 @param id
 @return IBAction
 */
-(IBAction)addInventory:(id)sender{
    _addInventoryViewController = [[AddInventoryViewController alloc]initWithNibName:@"AddInventoryViewController" bundle:nil];
    
    [self presentModalViewController:_addInventoryViewController animated:YES];
     
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_storeObject count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    _inventoryViewController = [[InventoryViewController alloc]initWithNibName:@"InventoryViewController" bundle:nil];
    
    _inventoryViewController.currentSelectedInventoryIndex = indexPath.row;
    
    [self.navigationController pushViewController:_inventoryViewController animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"InventoryCell";
    
    InventoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    if (cell == nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"InventoryCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Inventory *tempInventory = [_storeObject inventoryAtIndex:indexPath.row];

    
    cell.inventoryNameLabel.text = tempInventory.inventoryName;
    
    cell.totalCostLabel.text = [NSString stringWithFormat:@"$ %f",[tempInventory totalCost]];
    cell.totalItemsLabel.text = [NSString stringWithFormat:@"%d", [tempInventory totalItems]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd hh:mm"];
    
    cell.modifiedDateLabel.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:tempInventory.lastModified]];
    
    return cell;
}

- (void) viewDidAppear:(BOOL)animated {
    _storeObject = [InventoryStore shared];
    
    [self.tableView reloadData];

}
@end
