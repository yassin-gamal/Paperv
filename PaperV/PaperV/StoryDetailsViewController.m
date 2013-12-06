//
//  StoryDetailsViewController.m
//  PaperV
//
//  Created by mac on 11/27/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import "StoryDetailsViewController.h"
#import "CustomFriendCell.h"
#import "JSONModelLib.h"
#import "AsyncImageView.h"
#import "SVProgressHUD.h"
#import "StoryModel.h"

@interface StoryDetailsViewController ()


@property (nonatomic, strong) NSMutableArray *images;


@end

@implementation StoryDetailsViewController

@synthesize header;
@synthesize footer;

@synthesize commentField;

@synthesize carousel = _carousel;
@synthesize images = _images;
@synthesize avatar;

@synthesize storyID;
@synthesize story;
@synthesize storyTitle;
@synthesize storyOwner;
@synthesize totalLike;
@synthesize totlaRepost;
@synthesize totalComment;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if ( !(self = [super initWithCoder:aDecoder]) ) return nil;
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    header.backgroundColor = [UIColor colorWithRed:81.0/255 green:196.0/255 blue:212.0/255 alpha:1.0];
    
    commentField.delegate = self;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    commentField.leftView = paddingView;
    commentField.leftViewMode = UITextFieldViewModeAlways;
    
    
    //configure carousel
    _carousel.type = iCarouselTypeCoverFlow2;
    
    
    _images = story.media;
    [self.carousel reloadData];
    [self.tableView reloadData];
    
    storyTitle.text = story.title;
    
    avatar.image = [UIImage imageNamed:@"Avatar.png"];
    avatar.imageURL = [NSURL URLWithString:story.user_image];
    avatar.layer.cornerRadius = avatar.frame.size.width / 2;
    avatar.layer.masksToBounds = YES;
    
    storyOwner.text = story.user_fullname;
    totalLike.text = [NSString stringWithFormat:@"%ld", (long)story.total_like];
    totalComment.text = [NSString stringWithFormat:@"%ld", (long)story.comments.count];
    totlaRepost.text = [NSString stringWithFormat:@"%ld", (long)story.total_repost];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [commentField resignFirstResponder];
    return NO;
}


- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [_images count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        FXImageView *imageView = [[FXImageView alloc] initWithFrame:CGRectMake(0, 0, 250.0f, 250.0f)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.asynchronous = YES;
        imageView.reflectionScale = 0.20f;
        imageView.reflectionAlpha = 0.50f;
        imageView.reflectionGap = 1.0f;
        imageView.shadowOffset = CGSizeMake(0.0f, 2.0f);
        imageView.shadowBlur = 5.0f;
        imageView.cornerRadius = 0.0f;
        view = imageView;
        
        
        UILabel *imageCaption = [[UILabel alloc] initWithFrame:CGRectMake(0, 220, 260, 20)];
        imageCaption.textAlignment = NSTextAlignmentCenter;
        imageCaption.textColor = [UIColor grayColor];
        imageCaption.font = [UIFont fontWithName:@"Heiti SC" size:15];
        imageCaption.text = [_images[index] caption];
        [view addSubview:imageCaption];
        
    }
    
    //show placeholder
    //((FXImageView *)view).processedImage = [UIImage imageNamed:@"test_image1.png"];
    
    //set image
    NSString *imageUrl = [_images[index] image_url];
    ((FXImageView *)view).imageURL = [NSURL URLWithString:imageUrl];
    
    
    return view;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return story.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentModel* storyComments = story.comments[indexPath.row];
    
    static NSString *CellIdentifier = @"Cell";
    CustomFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[CustomFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    //set avatar
    if (![storyComments.user_image  isEqual: @""])
    {
        cell.friendAvatar.image = [UIImage imageNamed:@"Avatar.png"];
        cell.friendAvatar.imageURL = [NSURL URLWithString:storyComments.user_image];
        
        cell.friendAvatar.layer.cornerRadius = cell.friendAvatar.frame.size.width / 2;
        cell.friendAvatar.layer.masksToBounds = YES;
    }
    else
    {
        cell.friendAvatar.image = [UIImage imageNamed:@"Avatar.png"];
    }
    
    cell.commentOwner.text = storyComments.user_fullname;
    cell.comment.text = storyComments.user_comment;
    
    
    return cell;
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

- (IBAction)closeStory:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}
@end
