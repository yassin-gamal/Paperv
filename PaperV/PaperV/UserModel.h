//
//  UserModel.h
//  PaperV
//
//  Created by mac on 12/12/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Response.h"
#import "JSONModel.h"

@interface UserModel : Response

@property NSString *user_id;
@property NSString *user_name;
@property NSString *full_name;
@property NSString *user_image;
@property NSString *email;

@end
