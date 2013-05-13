//
//  InventoryViewController.m
//  Assignment 5
//
//  Created by
//  Rohan Narde - rsn5770@rit.edu
//  Amit Shroff - aas6521@rit.edu
//  on 9/22/12.
//  Copyright (c) 2012 Rohan Narde. All rights reserved.
//

#import "InventoryViewController.h"
#import "ItemTableViewController.h"
#import "Item.h"
#import "ItemTableViewController.h"
#import "AddNewInventoryItemViewController.h"
#import "Inventory.h"
#import "InventoryStore.h"

@interface InventoryViewController ()

@end

@implementation InventoryViewController
@synthesize currentSelectedInventoryIndex;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _currentSelectedInventory = [[InventoryStore shared] inventoryAtIndex:currentSelectedInventoryIndex];
    
    [self setTitle:_currentSelectedInventory.inventoryName];
    
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
    
    self.navigationItem.rightBarButtonItem = addBarButtonItem;
        //InventoryCell register
    [self.tableView registerNib:[UINib nibWithNibName:@"InventoryItemCell" bundle:nil]
         forCellReuseIdentifier:@"InventoryItemCell"];
    
    
    
    // Horizontal Swipe Gesture properties initialized for the horizontal swipe
    _swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                 action:@selector(swipeMethod:)];
    _swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [_swipeRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:_swipeRecognizer];

    
}
/**
 This function is used for Horizontal Swipe back to the CompanyInventoryViewController
 @param - sender - UISwipeGestureRecognizer which is the gesture for horizontal swipe
 @return - none
 */
-(void) swipeMethod: (UISwipeGestureRecognizer *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(IBAction)addNewItem:(id)sender{

    _newItemViewController = [[AddNewInventoryItemViewController alloc]initWithNibName:@"AddNewInventoryItemViewController" bundle:nil];

    _newItemViewController.currentSelectedInventoryIndex = currentSelectedInventoryIndex;
    
    [self presentModalViewController:_newItemViewController animated:YES];
    
    
}

-(void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_currentSelectedInventory removeItemAtIndex:indexPath.row];
    }
    [tableView reloadData];
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
    NSInteger rowCount = [_currentSelectedInventory count];
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"InventoryItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    Item *tempItem =[_currentSelectedInventory itemAtIndex:indexPath.row];
    
    cell.textLabel.text = tempItem.itemName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", tempItem.currentQuantity];
    
    return cell;
}


#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _itemTableViewController = [[ItemTableViewController alloc] initWithNibName:@"ItemTableViewController" bundle:nil];
    
    
    _itemTableViewController.currentSelectedInventoryIndex = currentSelectedInventoryIndex;
    _itemTableViewController.currentSelectedItemIndex = indexPath.row;
    
    [self.navigationController pushViewController:_itemTableViewController animated:YES];
    
}


@end
