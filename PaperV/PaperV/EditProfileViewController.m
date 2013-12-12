//
//  EditProfileViewController.m
//  PaperV
//
//  Created by mac on 11/24/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import "EditProfileViewController.h"
#import "AsyncImageView.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

@synthesize userNameField;
@synthesize emailField;
@synthesize passwordField;
@synthesize avatar;
@synthesize profileName;
@synthesize nextAvatar;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    userNameField.delegate = self;
    emailField.delegate = self;
    passwordField.delegate = self;
    
    passwordField.secureTextEntry = YES;
    
    UIView *namePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    userNameField.leftView = namePaddingView;
    userNameField.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIView *emailPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    emailField.leftView = emailPaddingView;
    emailField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *passPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    passwordField.leftView = passPaddingView;
    passwordField.leftViewMode = UITextFieldViewModeAlways;
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    profileName.text = [defaults objectForKey:@"full_name"];
    
    NSString *userImage = [defaults objectForKey:@"user_image"];
    
    //set avatar
    if (![userImage  isEqual: @""])
    {
        avatar.imageURL = [NSURL URLWithString:userImage];
        
        avatar.layer.cornerRadius = avatar.frame.size.width / 2;
        avatar.layer.masksToBounds = YES;
    }
    else
    {
        avatar.image = [UIImage imageNamed:@"Avatar.png"];
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [userNameField resignFirstResponder];
    [emailField resignFirstResponder];
    [passwordField resignFirstResponder];
    return NO;
}


- (IBAction)CancelEditing:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}


// move the textField above the keyboar

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 160; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (IBAction)changeImage:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:picker animated:YES];
}

#pragma mark - Image Picker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    nextAvatar.image = image;
    nextAvatar.layer.cornerRadius = nextAvatar.frame.size.width / 2;
    nextAvatar.layer.masksToBounds = YES;

    [picker dismissModalViewControllerAnimated:YES];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}


@end
