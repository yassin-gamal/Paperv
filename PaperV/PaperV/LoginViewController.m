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

@interface LoginViewController ()

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
    
    passwordField.secureTextEntry = YES;
    
    
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

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    // Make sure your segue name in storyboard is the same as this line
//    if ([[segue identifier] isEqualToString:@"GoToTab"])
//    {
//        
//        // Get reference to the destination view controller
//        TabBarViewController *tabController = [segue destinationViewController];
//
//
//        //        UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[TWTMainViewController new]];
//        [self.sideMenuViewController setMainViewController:tabController animated:YES closeMenu:YES];
//        //
//        //        // Pass any objects to the view controller here, like...
//        //        [vc setMyObjectHere:object];
//    }
//}

- (IBAction)login:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    [self.sideMenuViewController setMainViewController:[storyboard instantiateViewControllerWithIdentifier:@"TabViewController"] animated:YES closeMenu:YES];
}
@end

