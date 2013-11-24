//
//  StoryDetailsViewController.m
//  PaperV
//
//  Created by mac on 11/24/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import "StoryDetailsViewController.h"

@interface StoryDetailsViewController ()

@end

@implementation StoryDetailsViewController

@synthesize storyHeader;

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
    
    
    self.storyHeader.backgroundColor = [UIColor colorWithRed:81.0/255 green:196.0/255 blue:212.0/255 alpha:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)closeStory:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];

}


@end
