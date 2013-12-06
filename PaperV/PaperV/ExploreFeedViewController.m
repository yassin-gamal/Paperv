//
//  ExploreFeedViewController.m
//  PaperV
//
//  Created by mac on 11/22/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import "ExploreFeedViewController.h"
#import "CustomCell.h"
#import <QuartzCore/QuartzCore.h>
#import "TWTSideMenuViewController.h"
#import "JSONModelLib.h"
#import "FeedModel.h"
#import "AsyncImageView.h"
#import "SVProgressHUD.h"
#import "StoryDetailsViewController.h"
#import "StoryModel.h"

@interface ExploreFeedViewController ()
{
    FeedModel* _feed;
    FeedModel* _temp;
    
    StoryModel* _story;

    
    NSInteger pageNumber;
}

@end

@implementation ExploreFeedViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    pageNumber = 7;
    
    [SVProgressHUD showWithStatus:@"Fetching Stories"];
    
    //fetch the feed
    NSString *url = [NSString stringWithFormat:@"http://paperv.com/api/explore.php?page=%d",pageNumber];
    _feed = [[FeedModel alloc] initFromURLWithString:url completion:^(JSONModel *model, JSONModelError *err) {
        
        //json fetched
        
        //reload the table view
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        
    }];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return _feed.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    StoryFeedModel* storyData = _feed.data[indexPath.row];
    
    static NSString *CellIdentifier = @"Cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    else
    {
        //cancel loading previous image for cell
        [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:cell.storyPhoto];
        [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:cell.storyOwnerAvatar];
    }
    
    //set story image
    //set placeholder image or cell won't update when image is loaded
    cell.storyPhoto.image = [UIImage imageNamed:@"Empty.png"];
    //load the image
    cell.storyPhoto.imageURL = [NSURL URLWithString:storyData.photourl];
    
    //set avatar
    if (![storyData.user_image  isEqual: @""])
    {
        cell.storyOwnerAvatar.image = [UIImage imageNamed:@"Avatar.png"];
        cell.storyOwnerAvatar.imageURL = [NSURL URLWithString:storyData.user_image];
        
        cell.storyOwnerAvatar.layer.cornerRadius = cell.storyOwnerAvatar.frame.size.width / 2;
        cell.storyOwnerAvatar.layer.masksToBounds = YES;
    }
    else
    {
        cell.storyOwnerAvatar.image = [UIImage imageNamed:@"Avatar.png"];
    }
    
    
    cell.storyTitle.text = storyData.title;
    cell.storyOwnerName.text = storyData.user_fullname;
    cell.totalLike.text = [NSString stringWithFormat:@"%d", storyData.total_like];
    cell.totalComment.text = [NSString stringWithFormat:@"%d", storyData.total_comment];
    cell.totalRepost.text = [NSString stringWithFormat:@"%d", storyData.total_repost];
    
    
    return cell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StoryFeedModel* storyData = _feed.data[indexPath.row];
    
    [SVProgressHUD showWithStatus:@"Fetching More Stories"];
    
    NSString *url = [NSString stringWithFormat:@"http://paperv.com/api/get_story_by_id.php?user_id=1106&story_id=%@", storyData.story_id];
    _story = [[StoryModel alloc] initFromURLWithString:url completion:^(JSONModel *model, JSONModelError *err) {
        
        if (!err) {
            [self performSegueWithIdentifier:@"StoryDetails" sender:self];
        }
        else
        {
            [SVProgressHUD dismiss];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"PaperV" message: @"Error fetching this Story." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];
        }
        
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"StoryDetails"]) {
        
        StoryDetailsViewController *storyDetails = (StoryDetailsViewController*)segue.destinationViewController;
        storyDetails.story = _story.data;
        [SVProgressHUD dismiss];
    }
}

- (IBAction)openSide:(id)sender {
    
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}




// Load more stories

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.frame.size.height) {
        // Make new request and add UIActivityIndicator
        
        [SVProgressHUD showWithStatus:@"Fetching More Stories"];
        
        pageNumber++;
        NSString *url = [NSString stringWithFormat:@"http://paperv.com/api/explore.php?page=%d",pageNumber];
        
        //fetch the feed
        _temp = [[FeedModel alloc] initFromURLWithString:url completion:^(JSONModel *model, JSONModelError *err) {
            
            //json fetched
            [SVProgressHUD dismiss];
            
            
            [_feed.data addObjectsFromArray:_temp.data];
            
            //reload the table view
            [self.tableView reloadData];
            
            
        }];
    }
}



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */


@end
