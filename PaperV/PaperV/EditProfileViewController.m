//
//  EditProfileViewController.m
//  PaperV
//
//  Created by mac on 11/24/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

@synthesize userNameField;
@synthesize emailField;
@synthesize passwordField;
@synthesize avatar;

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
    
    userNameField.delegate = self;
    emailField.delegate = self;
    passwordField.delegate = self;
    
    passwordField.secureTextEntry = YES;
    
    
    UIImage *image = [UIImage imageNamed:@"Yehia"];
    [avatar setImage:image];
    avatar.layer.cornerRadius = avatar.frame.size.width / 2;
    avatar.layer.masksToBounds = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [userNameField resignFirstResponder];
    [emailField resignFirstResponder];
    [passwordField resignFirstResponder];
    return NO;
}


- (IBAction)CancelEditing:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}
@end
