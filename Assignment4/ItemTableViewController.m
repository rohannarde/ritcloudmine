//
//  ItemTableViewController.m
//  Assignment 4
//
//  Created by
//  Rohan Narde - rsn5770@rit.edu
//  Amit Shroff - aas6521@rit.edu
//  on 9/22/12.
//  Copyright (c) 2012 Rohan Narde. All rights reserved.
//

#import "ItemTableViewController.h"
#import "Item.h"
#import "Inventory.h"
#import "InventoryStore.h"

/**
 This ItemTableViewController gives the user the functionality to edit the Item data
 and also update the quantity on the item
 */
@interface ItemTableViewController ()

@end

@implementation ItemTableViewController

@synthesize itemNameTextField;
@synthesize currentQuantityTextField;
@synthesize unitCostTextField;
@synthesize inventoryDateTextField;
@synthesize addQuantityTextField;
@synthesize currentSelectedInventoryIndex;
@synthesize currentSelectedItemIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setItemNameTextField:nil];
    [self setCurrentQuantityTextField:nil];
    [self setUnitCostTextField:nil];
    [self setInventoryDateTextField:nil];
    [self setAddQuantityTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    _currentSelectedItem = [[[InventoryStore shared] inventoryAtIndex:currentSelectedInventoryIndex]itemAtIndex:currentSelectedItemIndex];
    
    [itemNameTextField setText:_currentSelectedItem.itemName];
    
    // Custom date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd hh:mm"];
    
    //Storing the updated values to the model object
    [inventoryDateTextField setText:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:_currentSelectedItem.lastInventoryDate]]];
    [currentQuantityTextField setText:[NSString stringWithFormat:@"%d",_currentSelectedItem.currentQuantity]];
    [unitCostTextField setText:[NSString stringWithFormat:@"%.4f",_currentSelectedItem.unitCost]];
    [self setTitle:_currentSelectedItem.itemName];
    
}

- (void) itemDateModifier {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd hh:mm"];
    _currentSelectedItem.lastInventoryDate = [NSDate date];
    [inventoryDateTextField setText:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:_currentSelectedItem.lastInventoryDate]]];
    [InventoryStore saveShared];
}

// The add quantity button
- (IBAction)addQuantityButton:(id)sender {
    
    [self itemDateModifier];
    _currentSelectedItem.currentQuantity += [[addQuantityTextField text]integerValue];
    [[[InventoryStore shared] inventoryAtIndex:currentSelectedInventoryIndex] changeIsModified:YES];
    [currentQuantityTextField setText:[NSString stringWithFormat:@"%d",_currentSelectedItem.currentQuantity]];
    [addQuantityTextField setText:@""];
    [InventoryStore saveShared];
    
}


#pragma mark UITextfield delegate


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
    
}

-(BOOL) textFieldShouldEndEditing:(UITextField *)textField{
    
    if(textField == itemNameTextField){
        _currentSelectedItem.itemName = [textField text];
        [self itemDateModifier];
        [self setTitle:_currentSelectedItem.itemName];
        [[[InventoryStore shared] inventoryAtIndex:currentSelectedInventoryIndex] changeIsModified:YES];
        [InventoryStore saveShared];
    }
    
    if(textField == unitCostTextField){
        _currentSelectedItem.unitCost = [[textField text]floatValue];
        
        [self itemDateModifier];
        [[[InventoryStore shared] inventoryAtIndex:currentSelectedInventoryIndex] changeIsModified:YES];
        [InventoryStore saveShared];
    }
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
