//
//  CustomGlideCell.h
//  PaperV
//
//  Created by mac on 12/9/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomGlideCell : UITableViewCell<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *image;

@property (strong, nonatomic) IBOutlet UITextField *caption;
@property (strong, nonatomic) IBOutlet UIButton *removeButton;
@property (strong, nonatomic) IBOutlet UIImageView *youtubeImage;
@property (strong, nonatomic) IBOutlet UITextField *videoURL;

@end
