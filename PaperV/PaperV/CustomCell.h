//
//  CustomCell.h
//  PaperV
//
//  Created by mac on 11/22/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *backgroundCellImage;

@property (strong, nonatomic) IBOutlet UIImageView *homeAvatar;
@property (strong, nonatomic) IBOutlet UIImageView *exploreAvatar;
@property (strong, nonatomic) IBOutlet UIImageView *likesAvatar;

@end
