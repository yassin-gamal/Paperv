//
//  CustomFollowCell.h
//  PaperV
//
//  Created by mac on 12/9/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomFollowCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *followButtonText;

@property (strong, nonatomic) IBOutlet UILabel *friendName;

@property (strong, nonatomic) IBOutlet UIImageView *friendAvatar;
@end
