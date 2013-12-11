//
//  GlideModel.h
//  PaperV
//
//  Created by mac on 12/9/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GlideModel @end

@interface GlideModel : NSObject

@property UIImage *image;
@property NSString *caption;
@property NSString *videoURL;

@end
