//
//  CustomGlideCell.m
//  PaperV
//
//  Created by mac on 12/9/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import "CustomGlideCell.h"

@implementation CustomGlideCell

@synthesize image;
@synthesize caption;
@synthesize removeButton;


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
