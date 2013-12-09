//
//  FriendModel.h
//  PaperV
//
//  Created by mac on 12/9/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "Response.h"

@protocol FriendModel @end

@interface FriendModel : JSONModel

@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *user_image;
@property (strong, nonatomic) NSString *user_fullname;

@end
