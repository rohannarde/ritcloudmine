//
//  AddInventoryViewController.m
//  Assignment 5
//
//  Created by
//  Rohan Narde - rsn5770@rit.edu
//  Amit Shroff - aas6521@rit.edu
//  on 9/22/12.
//  Copyright (c) 2012 Rohan Narde. All rights reserved.
//
#import "AddInventoryViewController.h"




@implementation AddInventoryViewController
@synthesize inventoryImage;
@synthesize newMedia;
@synthesize inventoryNameTextField;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidUnload {
    
    [self setInventoryNameTextField:nil];
    [self setInventoryImage:nil];
    [super viewDidUnload];
}

#pragma  mark- UIImagePicker delegatge methods

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info
                           objectForKey:UIImagePickerControllerMediaType];
    [self dismissModalViewControllerAnimated:YES];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info
                          objectForKey:UIImagePickerControllerOriginalImage];
        
        inventoryImage.image = image;
        
        if (newMedia)
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
		
	}
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"\
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

// Cancel button
- (IBAction)cancelLeftBarButton:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}


// Add inventory button
- (IBAction)addInventoryImage:(id)sender {
    // implementation of UIImagePicker
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                  (NSString *) kUTTypeImage,
                                  nil];
        imagePicker.allowsEditing = NO;
        [self presentModalViewController:imagePicker animated:YES];
        newMedia = NO;
    }
}

// Create inventory button
- (IBAction)createInventoryRightBarButton:(id)sender {

    
    if([inventoryNameTextField.text length] != 0){
        
        Inventory *inventory = [[Inventory alloc] initWithName:inventoryNameTextField.text];
        InventoryStore *inventoryStore = [InventoryStore shared];
        [inventoryStore addInventory:inventory];

        [inventoryNameTextField setText:@""];
        [self dismissModalViewControllerAnimated:YES];
        
        
    }
    
    
}

@end
