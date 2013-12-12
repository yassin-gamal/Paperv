//
//  FollowersViewController.h
//  PaperV
//
//  Created by mac on 11/23/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FollowersViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) IBOutlet UIImageView *profileAvatar;

- (IBAction)closeFollowers:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *profileName;

@end
