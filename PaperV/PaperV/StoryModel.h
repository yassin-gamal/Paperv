//
//  StoryModel.h
//  PaperV
//
//  Created by mac on 12/6/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Response.h"
#import "JSONModel.h"
#import "StoryDetailsModel.h"

@interface StoryModel : Response

@property StoryDetailsModel* data;

@end
