//

//  InventoryStoreUser.m

//  Assignment 5

//

//  Created by rsn5770 on 10/15/12.

//  Copyright (c) 2012 rsn5770. All rights reserved.

//



#import "InventoryStoreUserViewController.h"
#import "InventoryStore.h"

@implementation InventoryStoreUserViewController
@synthesize passwordTextField;
@synthesize userNameTextField;
@synthesize name;



- (IBAction)createNewLogin:(id)sender {
    
CMUser *user = [[CMUser alloc] initWithUserId:userNameTextField.text andPassword:passwordTextField.text];
    [user createAccountAndLoginWithCallback:^(CMUserAccountResult result, NSArray *messages){
        
        switch(result){           
            case CMUserAccountLoginSucceeded:
                break;
            case CMUserAccountLoginFailedIncorrectCredentials:
            {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"Login failed"
                                      message: @"Please check credentials"
                                      delegate: nil
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
            }
                break;
            default:
                break;
        }

    }];

}



- (IBAction)login:(id)sender {
    
    CMStore *store = [CMStore defaultStore];
    CMUser *user = [[CMUser alloc] initWithUserId:userNameTextField.text andPassword:passwordTextField.text];
    [user loginWithCallback:^(CMUserAccountResult result, NSArray *messages){
        switch(result){
            case CMUserAccountLoginSucceeded:
            {
                
                _companyInventoryViewController = [[CompanyInventoryViewController alloc] initWithNibName:@"CompanyInventoryViewController" bundle:nil];
                [_companyInventoryViewController setUser:user];
                [self.navigationController pushViewController:_companyInventoryViewController animated:YES];
                break;
                
            }
            case CMUserAccountLoginFailedIncorrectCredentials:
            {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"Login failed"
                                      message: @"Please check credentials"
                                      delegate: nil
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                
            }
                break;
                
            default:
                break;
                
        }
    }];

    store.user = user;
    [InventoryStore loadShared];
}



-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
        
   }
    return self;    
}


-(void)viewDidLoad{
    [self setTitle:@"User Login Screen"];
}


- (void)viewDidUnload {
    [super viewDidUnload];
    [self setUserNameTextField:nil];
    [self setPasswordTextField:nil];
}
@end