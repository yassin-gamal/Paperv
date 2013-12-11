//
//  StoryDetailsViewController.m
//  PaperV
//
//  Created by mac on 11/27/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import "StoryDetailsViewController.h"
#import "CustomCommentCell.h"
#import "JSONModelLib.h"
#import "AsyncImageView.h"
#import "SVProgressHUD.h"
#import "StoryModel.h"
#import "MessageResponseModel.h"
#import <MediaPlayer/MediaPlayer.h>


@interface StoryDetailsViewController ()
{
    MessageResponseModel * _msgResponse;
    UIWebView *webview;
}


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
    
    if (story.title.length > 25)
    {
        storyTitle.font = [UIFont fontWithName:@"Heiti SC" size:16];
    }
    if (story.title.length > 35)
    {
        storyTitle.font = [UIFont fontWithName:@"Heiti SC" size:14];
    }
    if (story.title.length > 35)
    {
        storyTitle.font = [UIFont fontWithName:@"Heiti SC" size:12];
    }
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
        // IMAGE
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
        
        
        // CAPTION
        UILabel *imageCaption = [[UILabel alloc] initWithFrame:CGRectMake(0, 220, 260, 20)];
        imageCaption.textAlignment = NSTextAlignmentCenter;
        imageCaption.textColor = [UIColor grayColor];
        imageCaption.font = [UIFont fontWithName:@"Heiti SC" size:15];
        imageCaption.text = [_images[index] caption];
        [view addSubview:imageCaption];
        
        if ([_images[index] caption].length > 30)
        {
            imageCaption.font = [UIFont fontWithName:@"Heiti SC" size:13];
        }
        
        
        // PALY BUTTON
        MediaModel *media = _images[index];
        if ( [media.type  isEqual: @"attachvideo"]) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//            [button setTitle:@"VIDEO" forState:UIControlStateNormal];
            button.frame = CGRectMake(85.0, 85.0, 80.0, 80.0);
            button.tag = index;
            
            UIImage *buttonImage = [UIImage imageNamed:@"Play.png"];
            [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
            [button addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [view addSubview:button];
        }
        
    }
    else
    {
        UILabel *imageCaption = [view subviews][1];
        imageCaption.text = [_images[index] caption];
        
        
        if ([[view subviews] count] > 2) {
            // PALY BUTTON
            UIButton *button = [view subviews][2];
            
            MediaModel *media = _images[index];
            if ( [media.type  isEqual: @"attachvideo"]) {
                
                button.hidden = NO;
                button.tag = index;
            }
            else
            {
                button.hidden = YES;
            }
        }
        
        else
        {
            // PALY BUTTON
            MediaModel *media = _images[index];
            if ( [media.type  isEqual: @"attachvideo"]) {
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                //            [button setTitle:@"VIDEO" forState:UIControlStateNormal];
                button.frame = CGRectMake(85.0, 85.0, 80.0, 80.0);
                button.tag = index;
                
                UIImage *buttonImage = [UIImage imageNamed:@"Play.png"];
                [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
                [button addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:button];

            }
        }
        
        
    }
    
    //show placeholder
    //((FXImageView *)view).processedImage = [UIImage imageNamed:@"test_image1.png"];
    
    //set image
    NSString *imageUrl = [_images[index] image_url];
    ((FXImageView *)view).imageURL = [NSURL URLWithString:imageUrl];
    
    
    return view;
}


-(IBAction)playAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    int indexrow = btn.tag;
    
    webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320,600)];
    NSString *url= [_images[indexrow] video_url];
    NSURL *nsurl=[NSURL URLWithString:url];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [webview loadRequest:nsrequest];
    webview.tag = 5;
    [self.view addSubview:webview];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(-5.0, 32.0, 55.0, 55.0);
    
    UIImage *buttonImage = [UIImage imageNamed:@"CloseWeb.png"];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(closeWebview:) forControlEvents:UIControlEventTouchUpInside];
    [webview addSubview:button];

    
  }

-(IBAction)closeWebview:(id)sender
{
//    webview = (UIWebView*)[self.view viewWithTag:5];
    webview.hidden = YES;
    
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
    CustomCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[CustomCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    {
        cell.friendAvatar.image = [UIImage imageNamed:@"Avatar.png"];
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


- (IBAction)followStoryOwner:(id)sender {
    
    NSString *message = [NSString stringWithFormat:@"Following %@", story.user_fullname];
    [SVProgressHUD showWithStatus:message];
    
    NSString *url = [NSString stringWithFormat:@"http://paperv.com/api/follow.php?user_id=1106&target_id=%@", story.user_id];
    _msgResponse = [[MessageResponseModel alloc] initFromURLWithString:url completion:^(JSONModel *model, JSONModelError *err) {
        
        if (_msgResponse.success == YES)
        {
            [SVProgressHUD dismiss];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"PaperV" message: _msgResponse.msg delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];
        }
        
        else
        {
            [SVProgressHUD dismiss];
            
            NSString *msg = [NSString stringWithFormat:@"You already follow %@", story.user_fullname];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"PaperV" message:msg delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];
            
        }
        
    }];
    
    
    
}

- (IBAction)likeStory:(id)sender {
    
    if (! story.is_liked)
    {
        NSString *url = [NSString stringWithFormat:@"http://paperv.com/api/like.php?user_id=1106&type_id=story&item_id=%@", story.story_id];
        _msgResponse = [[MessageResponseModel alloc] initFromURLWithString:url completion:^(JSONModel *model, JSONModelError *err) {
            
            if (_msgResponse.success == YES)
            {
                NSInteger likeCounter = story.total_like + 1;
                
                totalLike.text = [NSString stringWithFormat:@"%d", likeCounter];
            }
            
        }];
    }
}

- (IBAction)reglideStory:(id)sender {
    
    NSString *url = [NSString stringWithFormat:@"http://paperv.com/api/reglide.php?user_id=1106&story_id=%@", story.story_id];
    _msgResponse = [[MessageResponseModel alloc] initFromURLWithString:url completion:^(JSONModel *model, JSONModelError *err) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"PaperV" message: _msgResponse.msg delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];
        
        if (_msgResponse.success == YES)
        {
            NSInteger reglideCounter = story.total_repost + 1;
            
            totlaRepost.text = [NSString stringWithFormat:@"%d", reglideCounter];
        }
        
    }];
    
    
}

- (IBAction)addComment:(id)sender {
    
    if (commentField.text.length > 0) {
        
        NSString *comment = [commentField.text stringByReplacingOccurrencesOfString:@" "
                                                                         withString:@"%20"];
        
        NSString *url = [NSString stringWithFormat:@"http://paperv.com/api/add_comment.php?user_id=1106&story_id=%@&comment=%@", story.story_id, comment];
        _msgResponse = [[MessageResponseModel alloc] initFromURLWithString:url completion:^(JSONModel *model, JSONModelError *err) {
            
            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"PaperV" message: _follow.msg delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];
            
            if (_msgResponse.success == YES)
            {
                NSInteger commentCounter = story.comments.count + 1;
                totalComment.text = [NSString stringWithFormat:@"%d", commentCounter];
                
                CommentModel *commentModel = [[CommentModel alloc] init];
                commentModel.user_fullname = @"Yehia Elsaka";
                commentModel.user_image = @"";
                commentModel.user_id = @"1106";
                commentModel.user_comment = commentField.text;
                
                [story.comments addObject:commentModel];
                
                [self.tableView reloadData];
                
                commentField.text = @"";
            }
            
        }];
    }
}
@end
