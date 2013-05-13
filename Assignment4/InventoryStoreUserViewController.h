//
//  InventoryStoreUser.h
//  Assignment 5
//
//  Created by rsn5770 on 10/15/12.
//  Copyright (c) 2012 rsn5770. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "CompanyInventoryViewController.h"
#import <CloudMine/CloudMine.h>

@class CompanyInventoryViewController;

@interface InventoryStoreUserViewController : UIViewController {
    
    CompanyInventoryViewController *_companyInventoryViewController;
    
}

/**
 This function checks the username and password entered
 */
- (IBAction)login:(id)sender;

/**
 This function creates an account with the username and password credentials
 */
- (IBAction)createNewLogin:(id)sender;


@property (nonatomic) NSString *name;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;





@end