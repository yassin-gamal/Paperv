//
//  AboutViewController.m
//  PaperV
//
//  Created by mac on 12/12/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import "TextSideViewController.h"
#import "TWTSideMenuViewController.h"

@interface TextSideViewController ()

@end

@implementation TextSideViewController
@synthesize pageTitle;
@synthesize pageContent;
@synthesize header;
@synthesize contactWebview;

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
    
    header.backgroundColor = [UIColor colorWithRed:81.0/255 green:196.0/255 blue:212.0/255 alpha:1.0];
    
    pageContent.editable = NO;
    
    
    NSString *url= @"http://paperv.com/contact/";
    NSURL *nsurl=[NSURL URLWithString:url];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [contactWebview loadRequest:nsrequest];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (IBAction)openSide:(id)sender {
    
     [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}
@end
