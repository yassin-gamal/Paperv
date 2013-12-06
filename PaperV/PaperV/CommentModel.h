//
//  CommentModel.h
//  PaperV
//
//  Created by mac on 12/6/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol CommentModel @end

@interface CommentModel : JSONModel

@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *user_comment;
@property (strong, nonatomic) NSString *user_fullname;
@property (strong, nonatomic) NSString *user_image;

@end
