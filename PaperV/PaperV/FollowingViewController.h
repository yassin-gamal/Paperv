//
//  FollowingViewController.h
//  PaperV
//
//  Created by mac on 11/23/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FollowingViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *profileAvatar;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
- (IBAction)closeFollowing:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *profileName;

@end
