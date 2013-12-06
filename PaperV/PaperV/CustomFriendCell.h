//
//  CustomFriendCell.h
//  PaperV
//
//  Created by mac on 11/23/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomFriendCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *friendAvatar;

@property (strong, nonatomic) IBOutlet UIButton *followButtonText;

@property (strong, nonatomic) IBOutlet UILabel *commentOwner;
@property (strong, nonatomic) IBOutlet UILabel *comment;

@end
