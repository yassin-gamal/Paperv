//
//  TabBarViewController.m
//  PaperV
//
//  Created by mac on 11/21/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import "TabBarViewController.h"
#import "TWTSideMenuViewController.h"

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

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    // Make sure your segue name in storyboard is the same as this line
//    if ([[segue identifier] isEqualToString:@"GoToTab"])
//    {
//        
//        // Get reference to the destination view controller
//        TabBarViewController *tabController = [segue destinationViewController];
//        
//        //        UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[TWTMainViewController new]];
//        //        [tabController.sideMenuViewController setMainViewController:tabController animated:YES closeMenu:YES];
//        //
//        //        // Pass any objects to the view controller here, like...
//        //        [vc setMyObjectHere:object];
//    }
//}


@end
