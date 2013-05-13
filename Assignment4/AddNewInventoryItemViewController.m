//
//  AddNewInventoryItemViewController.m
//  Assignment 5
//
//  Created by
//  Rohan Narde - rsn5770@rit.edu
//  Amit Shroff - aas6521@rit.edu
//  on 9/22/12.
//  Copyright (c) 2012 Rohan Narde. All rights reserved.
//
#import "AddNewInventoryItemViewController.h"
#import <CloudMine/CloudMine.h>
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>


@interface AddNewInventoryItemViewController ()

@end

@implementation AddNewInventoryItemViewController

@synthesize itemNameTextField;
@synthesize itemQuantityTextField;
@synthesize itemUnitCostTextField;
@synthesize currentSelectedInventoryIndex;

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
    //[self setTitle:@"User Login Screen:"];
    [itemQuantityTextField setText:@"0"];
    [itemUnitCostTextField setText:@"0.00"];
}

- (void)viewDidUnload
{
    [self setItemNameTextField:nil];
    [self setItemQuantityTextField:nil];
    [self setItemUnitCostTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

// bar button action for create
- (IBAction)createLeftBarButton:(id)sender {
    
    if (([itemNameTextField.text length] != 0 ) && ([itemQuantityTextField.text length] != 0) && ([itemUnitCostTextField.text length] != 0)){
        
        Item *newItem = [[Item alloc] initWithDetails:itemNameTextField.text currentQuantity:[itemQuantityTextField.text intValue] inventoryDate:[NSDate date] unitCost:[itemUnitCostTextField.text floatValue]];
        InventoryStore *inventoryStore = [InventoryStore shared];
        
        Inventory *saveInventory = [inventoryStore inventoryAtIndex:currentSelectedInventoryIndex];
        
        
        [saveInventory addItem:newItem];
        
        [saveInventory changeIsModified:YES];
    
        
        [self dismissModalViewControllerAnimated:YES];
        
    }
   
    
}

// bar button action for cancel
- (IBAction)cancelRightBarButton:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}
@end
