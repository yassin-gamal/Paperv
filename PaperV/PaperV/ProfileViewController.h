//
//  ProfileViewController.h
//  PaperV
//
//  Created by mac on 11/23/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *profileAvatar;

@property (strong, nonatomic) IBOutlet UITableView *myTableView;

- (IBAction)openSide:(id)sender;

@end
