//
//  FollowingViewController.m
//  PaperV
//
//  Created by mac on 11/23/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import "FollowingViewController.h"
#import "CustomFriendCell.h"

@interface FollowingViewController ()

@end

@implementation FollowingViewController


@synthesize myTableView;
@synthesize profileAvatar;

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
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
    UIImage *image = [UIImage imageNamed:@"Yehia"];
    [profileAvatar setImage:image];
    profileAvatar.layer.cornerRadius = profileAvatar.frame.size.width / 2;
    profileAvatar.layer.masksToBounds = YES;
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
    CustomFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[CustomFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    
    
    [cell.followButtonText setTitleColor:[UIColor colorWithRed:235.0/255 green:91.0/255 blue:76.0/255 alpha:1.0] forState:UIControlStateNormal];
    
    
    UIImage *image = [UIImage imageNamed:@"Yassin"];
    [cell.friendAvatar setImage:image];
    cell.friendAvatar.layer.cornerRadius = cell.friendAvatar.frame.size.width / 2;
    cell.friendAvatar.layer.masksToBounds = YES;
    
    
    
    // Configure the cell...
    
    return cell;
}


@end
