//
//  ViewController.m
//  PaperV
//
//  Created by Yassin Gamal on 11/17/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import "LoginViewController.h"
#import "TabBarViewController.h"
#import "TWTSideMenuViewController.h"
#import "SVProgressHUD.h"
#import "JSONModelLib.h"
#import "UserModel.h"

@interface LoginViewController ()
{
    UserModel *_user;
}

@end

@implementation LoginViewController

@synthesize bottomView;
@synthesize userNameField;
@synthesize passwordField;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]]];
    [bottomView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Bottom"]]];
    
    userNameField.delegate = self;
    passwordField.delegate = self;
    
    UIView *namePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    userNameField.leftView = namePaddingView;
    userNameField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *passPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    passwordField.leftView = passPaddingView;
    passwordField.leftViewMode = UITextFieldViewModeAlways;
    
    passwordField.secureTextEntry = YES;
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString* userName = [defaults objectForKey:@"user_name"];
    if (userName.length > 0) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        [self.sideMenuViewController setMainViewController:[storyboard instantiateViewControllerWithIdentifier:@"TabViewController"] animated:YES closeMenu:YES];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [userNameField resignFirstResponder];
    [passwordField resignFirstResponder];
    return NO;
}


- (IBAction)login:(id)sender {
    
    if (![userNameField.text  isEqual: @""] && ![passwordField.text  isEqual: @""])
    {
        [SVProgressHUD showWithStatus:@"Logging In ..."];
        
        //fetch the feed
        NSString *url = [NSString stringWithFormat:@"http://paperv.com/api/login.php?login=%@&password=%@", userNameField.text, passwordField.text];
        _user = [[UserModel alloc] initFromURLWithString:url completion:^(JSONModel *model, JSONModelError *err) {
            
            //json fetched
            
            [SVProgressHUD dismiss];
            
            if (_user.success) {
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                [self.sideMenuViewController setMainViewController:[storyboard instantiateViewControllerWithIdentifier:@"TabViewController"] animated:YES closeMenu:YES];
                
                
                // Store the data
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:_user.user_id forKey:@"user_id"];
                [defaults setObject:_user.user_name forKey:@"user_name"];
                [defaults setObject:_user.full_name forKey:@"full_name"];
                [defaults setObject:_user.user_image forKey:@"user_image"];
                [defaults setObject:_user.email forKey:@"email"];
                [defaults synchronize];
                
            }
            
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"PaperV" message: @"Error login data." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];
            }
            
        }];
        
    }
    
    
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"PaperV" message: @"Error login data." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];
    }
    
    
}
@end

