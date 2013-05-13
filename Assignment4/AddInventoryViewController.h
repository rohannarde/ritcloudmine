//
//  AddInventoryViewController.h
//  Assignment 5
//
//  Created by
//  Rohan Narde - rsn5770@rit.edu
//  Amit Shroff - aas6521@rit.edu
//  on 9/22/12.
//  Copyright (c) 2012 Rohan Narde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Inventory.h"
#import "InventoryStore.h"
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
/**
 This interface is the modal view controller used to add a new inventory store to the application
 */
@interface AddInventoryViewController : UIViewController
<UIImagePickerControllerDelegate,
UINavigationControllerDelegate>{
    CompanyInventoryViewController *_companyObject;
}

/**
 This function is called when the user presses the cancel button. It will dismiss the current modal view controller and return back to the CompanyINventoryViewController view.
 @param id
 @return IBAction
 */
- (IBAction)cancelLeftBarButton:(id)sender;

/**
 This function is called to load an image from the camera roll
 @param id
 @return IBAction
 */
- (IBAction)addInventoryImage:(id)sender;

/**
 This function is called when the user presses the create button. It will save the inventory store into the application
 @param id
 @return IBAction
 */
- (IBAction)createInventoryRightBarButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *inventoryImage;
@property (weak, nonatomic) IBOutlet UITextField *inventoryNameTextField;
@property (nonatomic) BOOL newMedia;

@end
