//
//  CustomCell.h
//  PaperV
//
//  Created by mac on 11/22/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *storyPhoto;

@property (strong, nonatomic) IBOutlet UIImageView *storyOwnerAvatar;

@property (strong, nonatomic) IBOutlet UILabel *storyTitle;

@property (strong, nonatomic) IBOutlet UILabel *storyOwnerName;
@property (strong, nonatomic) IBOutlet UILabel *totalLike;
@property (strong, nonatomic) IBOutlet UILabel *totalRepost;
@property (strong, nonatomic) IBOutlet UILabel *totalComment;

@end
