//
//  HomeFeedViewController.h
//  PaperV
//
//  Created by mac on 11/22/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarViewController.h"

@interface HomeFeedViewController : UITableViewController <UITableViewDelegate>
- (IBAction)openSide:(id)sender;

@property TabBarViewController* homeTabController;




@end
