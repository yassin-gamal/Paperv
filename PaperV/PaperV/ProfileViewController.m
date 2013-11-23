//
//  ProfileViewController.m
//  PaperV
//
//  Created by mac on 11/23/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import "ProfileViewController.h"
#import "CustomCell.h"
#import <QuartzCore/QuartzCore.h>



@interface ProfileViewController ()

@end

@implementation ProfileViewController

@synthesize profileAvatar;
@synthesize myTableView;


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
    
       
    UIImage *image = [UIImage imageNamed:@"Yehia"];
    [profileAvatar setImage:image];
    profileAvatar.layer.cornerRadius = profileAvatar.frame.size.width / 2;
    profileAvatar.layer.masksToBounds = YES;
    
        self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    UIImage *image = [UIImage imageNamed:@"Yehia"];
    [cell.profileAvatar setImage:image];
    cell.profileAvatar.layer.cornerRadius = cell.profileAvatar.frame.size.width / 2;
    cell.profileAvatar.layer.masksToBounds = YES;
    
    
    
    // Configure the cell...
    
    return cell;
}




@end
