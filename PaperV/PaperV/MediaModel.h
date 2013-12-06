//
//  MediaModel.h
//  PaperV
//
//  Created by mac on 12/6/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol MediaModel @end

@interface MediaModel : JSONModel

@property (strong, nonatomic) NSString *media_id;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *image_url;
@property (strong, nonatomic) NSString *video_url;
@property (strong, nonatomic) NSString *caption;

@end
