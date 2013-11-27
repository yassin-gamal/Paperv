//
//  StoryDetailsViewController.h
//  PaperV
//
//  Created by mac on 11/27/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryDetailsViewController : UITableViewController
- (IBAction)closeStory:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *header;
@property (strong, nonatomic) IBOutlet UILabel *footer;

@end
