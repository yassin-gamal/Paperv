//
//  GlideViewController.h
//  PaperV
//
//  Created by mac on 11/23/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GlideViewController : UIViewController<UIActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
- (IBAction)openSide:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;
- (IBAction)showActionSheet:(id)sender;
@property (strong, nonatomic) IBOutlet UIPickerView *myPicker;

@property (strong, nonatomic)NSArray *colorArray;
@property (strong, nonatomic) IBOutlet UIImageView *avatar;

@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) IBOutlet UITextField *storyTitleField;


@end
