//
//  StoryDetailsViewController.h
//  PaperV
//
//  Created by mac on 11/27/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "FXImageView.h"

#import "StoryDetailsModel.h"



@interface StoryDetailsViewController : UITableViewController<iCarouselDataSource, UITextFieldDelegate>

- (IBAction)closeStory:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *header;
@property (strong, nonatomic) IBOutlet UILabel *footer;


@property (strong, nonatomic) IBOutlet iCarousel *carousel;
@property (strong, nonatomic) IBOutlet UITextField *commentField;
@property (strong, nonatomic) IBOutlet UIImageView *avatar;

@property (strong, nonatomic) IBOutlet UILabel *storyTitle;
@property (strong, nonatomic) IBOutlet UILabel *storyOwner;
@property (strong, nonatomic) IBOutlet UILabel *totalLike;
@property (strong, nonatomic) IBOutlet UILabel *totlaRepost;

@property (strong, nonatomic) IBOutlet UILabel *totalComment;

- (IBAction)followStoryOwner:(id)sender;

- (IBAction)likeStory:(id)sender;

- (IBAction)reglideStory:(id)sender;

- (IBAction)addComment:(id)sender;


@property NSString *storyID;
@property StoryDetailsModel *story;


@end
