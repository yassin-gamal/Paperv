//
//  StoryModel.h
//  PaperV
//
//  Created by mac on 12/6/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

#import "CommentModel.h"
#import "MediaModel.h"

@interface StoryDetailsModel : JSONModel

@property (strong, nonatomic) NSString *story_id;
@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) NSInteger total_like;
@property (assign, nonatomic) NSInteger total_repost;

@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *user_image;
@property (strong, nonatomic) NSString *user_fullname;

@property NSMutableArray<CommentModel>* comments;
@property NSMutableArray<MediaModel>* media;

@property BOOL is_liked;

@end
