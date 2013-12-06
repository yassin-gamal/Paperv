//
//  FeedModel.h
//  PaperV
//
//  Created by mac on 12/3/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Response.h"
#import "JSONModel.h"
#import "StoryFeedModel.h"

@interface FeedModel : Response

@property NSMutableArray<StoryFeedModel>* data;


@end
