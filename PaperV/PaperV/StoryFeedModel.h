//
//  StoryFeedItem.h
//  PaperV
//
//  Created by mac on 12/3/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "Response.h"

@protocol StoryFeedModel @end

@interface StoryFeedModel : JSONModel

// Strory Params
@property (strong, nonatomic) NSString *story_id;
@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) NSInteger total_comment;
@property (assign, nonatomic) NSInteger total_like;
@property (assign, nonatomic) NSInteger total_repost;
@property (strong, nonatomic) NSString *photourl;


// Story's Owner params
@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *user_image;
@property (strong, nonatomic) NSString *user_fullname;


@end
