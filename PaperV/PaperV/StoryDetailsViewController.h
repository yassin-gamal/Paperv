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

@interface StoryDetailsViewController : UITableViewController<iCarouselDataSource, UITextFieldDelegate>

- (IBAction)closeStory:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *header;
@property (strong, nonatomic) IBOutlet UILabel *footer;


@property (strong, nonatomic) IBOutlet iCarousel *carousel;
@property (strong, nonatomic) IBOutlet UITextField *comment;

@end
