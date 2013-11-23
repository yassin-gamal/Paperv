//
//  CustomCell.m
//  PaperV
//
//  Created by mac on 11/22/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

@synthesize backgroundCellImage;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
                 }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
