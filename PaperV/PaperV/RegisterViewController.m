//
//  RegisterViewController.m
//  PaperV
//
//  Created by mac on 11/20/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

@synthesize nameField;
@synthesize emailField;
@synthesize passField;
@synthesize repeatPassField;

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
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]]];
    
    nameField.delegate = self;
    emailField.delegate = self;
    passField.delegate = self;
    repeatPassField.delegate = self;
    
    passField.secureTextEntry = YES;
    repeatPassField.secureTextEntry = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [nameField resignFirstResponder];
    [emailField resignFirstResponder];
    [passField resignFirstResponder];
    [repeatPassField resignFirstResponder];
    return NO;
}

@end
