//
//  AppDelegate.m
//  Assignment 5
//
//  Created by
//  Rohan Narde - rsn5770@rit.edu
//  Amit Shroff - aas6521@rit.edu
//  on 9/22/12.
//  Copyright (c) 2012 Rohan Narde. All rights reserved.
//

#import "AppDelegate.h"
#import "InventoryViewController.h"
#import "CompanyInventoryViewController.h"
#import "InventoryStore.h"
#import <CloudMine/CloudMine.h>
#import "InventoryStoreUserViewController.h"

// App credentials
static NSString * const kAppIdentifier = @"076a1c6f95e14687b443b2845bb3539e";
static NSString * const kAppSecret = @"8f4c2959e6624697877fba1e6558f929";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // The credentials for our InventoryStore app.
    CMAPICredentials *credentials = [CMAPICredentials sharedInstance];
    credentials.appIdentifier = kAppIdentifier;
    credentials.appSecret = kAppSecret;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Set the root view controller here
    InventoryStoreUserViewController *inventoryStoreUser = [[InventoryStoreUserViewController alloc]initWithNibName:@"InventoryStoreUserViewController" bundle:nil];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:inventoryStoreUser];
    
    [self.window setRootViewController:navigationController];
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
   
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //[InventoryStore saveShared];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
