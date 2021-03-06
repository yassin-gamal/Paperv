//
//  FollowersViewController.m
//  PaperV
//
//  Created by mac on 11/23/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import "FollowersViewController.h"
#import "CustomFollowCell.h"
#import "JSONModelLib.h"
#import "FollowModel.h"
#import "SVProgressHUD.h"
#import "FriendModel.h"
#import "AsyncImageView.h"
#import "MessageResponseModel.h"

@interface FollowersViewController ()
{
    FollowModel *_followers;
    MessageResponseModel *_response;
    NSString *user_id;
}


@end

@implementation FollowersViewController

@synthesize myTableView;
@synthesize profileAvatar;
@synthesize profileName;

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
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    user_id = [defaults objectForKey:@"user_id"];
    profileName.text = [defaults objectForKey:@"full_name"];
    
    NSString *userImage = [defaults objectForKey:@"user_image"];
    
    //set avatar
    if (![userImage  isEqual: @""])
    {
        profileAvatar.imageURL = [NSURL URLWithString:userImage];
        
        profileAvatar.layer.cornerRadius = profileAvatar.frame.size.width / 2;
        profileAvatar.layer.masksToBounds = YES;
    }
    else
    {
        profileAvatar.image = [UIImage imageNamed:@"Avatar.png"];
    }
    
    
    
    [SVProgressHUD showWithStatus:@"Fetching Followers"];
    
    //fetch the feed
    NSString *url = [NSString stringWithFormat:@"http://paperv.com/api/user_followers.php?user_id=%@", user_id];
    _followers = [[FollowModel alloc] initFromURLWithString:url completion:^(JSONModel *model, JSONModelError *err) {
        
        //json fetched
        
        //reload the table view
        [self.myTableView reloadData];
        [SVProgressHUD dismiss];
        
    }];
    
    
    
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
    return _followers.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendModel* friendData = _followers.data[indexPath.row];
    
    static NSString *CellIdentifier = @"Cell";
    CustomFollowCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[CustomFollowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    {
        cell.friendAvatar.image = [UIImage imageNamed:@"Avatar.png"];
    }
    
    
    //set avatar
    if (![friendData.user_image  isEqual: @""])
    {
        cell.friendAvatar.image = [UIImage imageNamed:@"Avatar.png"];
        cell.friendAvatar.imageURL = [NSURL URLWithString:friendData.user_image];
        
        cell.friendAvatar.layer.cornerRadius = cell.friendAvatar.frame.size.width / 2;
        cell.friendAvatar.layer.masksToBounds = YES;
    }
    else
    {
        cell.friendAvatar.image = [UIImage imageNamed:@"Avatar.png"];
    }
    
    cell.friendName.text = friendData.user_fullname;
    
    [cell.followButtonText setTitleColor:[UIColor colorWithRed:81.0/255 green:196.0/255 blue:212.0/255 alpha:1.0] forState:UIControlStateNormal];
    
    cell.followButtonText.tag = indexPath.row;
    [cell.followButtonText addTarget:self action:@selector(follow:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(IBAction)follow:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    int indexrow = btn.tag;
    
    FriendModel* friendData = _followers.data[indexrow];
    
    NSString *msg = [NSString stringWithFormat:@"Follow %@", friendData.user_fullname];
    [SVProgressHUD showWithStatus:msg];
    
    //fetch the feed
    NSString *url = [NSString stringWithFormat:@"http://paperv.com/api/follow.php?user_id=%@&target_id=%@", user_id, friendData.user_id];
    _response = [[MessageResponseModel alloc] initFromURLWithString:url completion:^(JSONModel *model, JSONModelError *err) {
        
        if (_response.success == YES)
        {
            [SVProgressHUD dismiss];
            
//            [_followers.data removeObjectAtIndex:indexrow];
//            [self.myTableView reloadData];
            
        }
        else
        {
            [SVProgressHUD dismiss];
            
            NSString *msg = [NSString stringWithFormat:@"You already follow %@", friendData.user_fullname];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"PaperV" message:msg delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];
            
        }
        
    }];
    
    
}



- (IBAction)closeFollowers:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
    
}
@end
