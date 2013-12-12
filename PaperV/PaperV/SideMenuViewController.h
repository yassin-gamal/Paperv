//
//  SideMenuViewController.h
//  PaperV
//
//  Created by mac on 11/27/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UIImageView *avatar;

@property (strong, nonatomic) IBOutlet UILabel *userName;

- (IBAction)openHome:(id)sender;
- (IBAction)openAbout:(id)sender;
- (IBAction)openPrivacy:(id)sender;
- (IBAction)openTerms:(id)sender;

- (IBAction)openContact:(id)sender;
- (IBAction)logout:(id)sender;

@end
