//
//  TabBarViewController.m
//  PaperV
//
//  Created by mac on 11/21/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

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
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    [[UINavigationBar appearance] setBarTintColor: [UIColor colorWithRed:81.0/255 green:196.0/255 blue:212.0/255 alpha:1.0]];
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:81.0/255 green:196.0/255 blue:212.0/255 alpha:1.0]];


    [[UINavigationBar appearance] setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor whiteColor]}];

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
