//
//  RegisterViewController.m
//  PaperV
//
//  Created by mac on 11/20/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import "RegisterViewController.h"
#import "TWTSideMenuViewController.h"

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
    
    UIView *namePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    nameField.leftView = namePaddingView;
    nameField.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIView *emailPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    emailField.leftView = emailPaddingView;
    emailField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *passPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    passField.leftView = passPaddingView;
    passField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *repPassPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    repeatPassField.leftView = repPassPaddingView;
    repeatPassField.leftViewMode = UITextFieldViewModeAlways;
    
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




- (IBAction)register:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    [self.sideMenuViewController setMainViewController:[storyboard instantiateViewControllerWithIdentifier:@"TabViewController"] animated:YES closeMenu:YES];
    
}


// move the textField above the keyboar

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 120; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
@end
