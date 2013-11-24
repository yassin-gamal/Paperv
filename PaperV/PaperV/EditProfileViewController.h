//
//  EditProfileViewController.h
//  PaperV
//
//  Created by mac on 11/24/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *userNameField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)CancelEditing:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *avatar;

@end
