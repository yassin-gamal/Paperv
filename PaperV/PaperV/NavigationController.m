//
//  NavigationController.m
//  PaperV
//
//  Created by Yassin Gamal on 11/17/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController


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
    
    [[UINavigationBar appearance] setBarTintColor: [UIColor colorWithRed:81.0/255 green:196.0/255 blue:212.0/255 alpha:1.0]];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    
    //    [self performSelector:@selector(hideNavBar) withObject:nil afterDelay:0.0];
}


-(void) hideNavBar {
    if (self.navigationController.navigationBar.hidden == NO)
    {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
        // reload view after remove the navigation bar
        [self loadView];
        [self viewWillAppear:YES];
        
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
