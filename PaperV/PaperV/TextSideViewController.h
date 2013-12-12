//
//  AboutViewController.h
//  PaperV
//
//  Created by mac on 12/12/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextSideViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *pageTitle;
@property (strong, nonatomic) IBOutlet UITextView *pageContent;
- (IBAction)openSide:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *header;
@property (strong, nonatomic) IBOutlet UIWebView *contactWebview;

@end
