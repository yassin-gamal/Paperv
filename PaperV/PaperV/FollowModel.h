//
//  FollowModel.h
//  PaperV
//
//  Created by mac on 12/9/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Response.h"
#import "JSONModel.h"
#import "FriendModel.h"

@interface FollowModel : Response

@property NSMutableArray<FriendModel>* data;

@end
