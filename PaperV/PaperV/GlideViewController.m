//
//  GlideViewController.m
//  PaperV
//
//  Created by mac on 11/23/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import "GlideViewController.h"
#import "TWTSideMenuViewController.h"
#import "GlideModel.h"
#import "CustomGlideCell.h"
#import "ASIFormDataRequest.h"
#import "AsyncImageView.h"




@interface GlideViewController ()
{
    UITextField *cellTextField;
}

@property (nonatomic, strong) ALAssetsLibrary * assetLibrary;
@property (nonatomic, strong) NSMutableArray * sessions;
@property (nonatomic, strong) NSMutableArray * glideData;


@end



@implementation GlideViewController

@synthesize myScrollView;

@synthesize myTableView;
@synthesize storyTitleField;

@synthesize avatar;


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
    
    // Allocate Asset Library
    ALAssetsLibrary * assetLibrary = [[ALAssetsLibrary alloc] init];
    [self setAssetLibrary:assetLibrary];
    
    // Allocate Sessions Array
    NSMutableArray * sessions = [NSMutableArray new];
    [self setSessions:sessions];
    
    // Start the Aviary Editor OpenGL Load
    [AFOpenGLManager beginOpenGLLoad];
    
    
    
    
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.transform = CGAffineTransformMakeRotation(M_PI/-2);
    
    storyTitleField.delegate = self;
    storyTitleField.tag = -1;
    
    
    //    myScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    //    [[self myScrollView] setScrollEnabled:YES];
    //    [[self myScrollView] setContentSize:CGSizeMake(320, 800)];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
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
    [storyTitleField resignFirstResponder];
    [cellTextField resignFirstResponder];
    return NO;
}


- (IBAction)openSide:(id)sender {
    
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.myScrollView.contentOffset = CGPointZero;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    
    if (self.glideData != nil) {
        return self.glideData.count;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GlideModel* data = self.glideData[indexPath.row];
    
    static NSString *CellIdentifier = @"Cell";
    CustomGlideCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[CustomGlideCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.contentView.transform = CGAffineTransformMakeRotation(M_PI/2);
    }
    
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI/2);
    
    if (self.glideData != nil)
    {
        if (![data.videoURL  isEqual: @""])
        {
            cell.youtubeImage.hidden = NO;
            cell.videoURL.hidden = NO;
            cell.videoURL.text = data.videoURL;
            cell.videoURL.enabled = NO;
            cell.caption.placeholder = @"Video Caption";
            cell.image.image  = nil;
        }
        else
        {
            cell.youtubeImage.hidden = YES;
            cell.videoURL.hidden = YES;
            cell.image.image = data.image;
        }
        
        cell.caption.text = data.caption;
        
        cell.removeButton.tag = indexPath.row;
        [cell.removeButton addTarget:self action:@selector(removeItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    cell.caption.tag = indexPath.row;
    cellTextField = cell.caption;
    cellTextField.delegate = self;
    
    return cell;
}


-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    int indexrow = textField.tag;
    if (self.glideData != nil && indexrow != -1)
    {
        GlideModel * data = [self.glideData objectAtIndex:indexrow];
        data.caption = textField.text;
        [self.glideData setObject:data atIndexedSubscript:indexrow];
    }
}


-(IBAction)removeItem:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    int indexrow = btn.tag;
    
    [self.glideData removeObjectAtIndex:indexrow];
    [self.myTableView reloadData];
}



#pragma mark - Photo Editor Launch Methods

- (void) launchEditorWithAsset:(ALAsset *)asset
{
    UIImage * editingResImage = [self editingResImageForAsset:asset];
    UIImage * highResImage = [self highResImageForAsset:asset];
    
    [self launchPhotoEditorWithImage:editingResImage highResolutionImage:highResImage];
}

- (void) launchEditorWithSampleImage
{
    UIImage * sampleImage = [UIImage imageNamed:@"Demo.png"];
    
    [self launchPhotoEditorWithImage:sampleImage highResolutionImage:nil];
}

#pragma mark - Photo Editor Creation and Presentation
- (void) launchPhotoEditorWithImage:(UIImage *)editingResImage highResolutionImage:(UIImage *)highResImage
{
    // Customize the editor's apperance. The customization options really only need to be set once in this case since they are never changing, so we used dispatch once here.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setPhotoEditorCustomizationOptions];
    });
    
    // Initialize the photo editor and set its delegate
    AFPhotoEditorController * photoEditor = [[AFPhotoEditorController alloc] initWithImage:editingResImage];
    [photoEditor setDelegate:self];
    
    // If a high res image is passed, create the high res context with the image and the photo editor.
    if (highResImage) {
        [self setupHighResContextForPhotoEditor:photoEditor withImage:highResImage];
    }
    
    // Present the photo editor.
    [self presentViewController:photoEditor animated:YES completion:nil];
}

- (void) setupHighResContextForPhotoEditor:(AFPhotoEditorController *)photoEditor withImage:(UIImage *)highResImage
{
    // Capture a reference to the editor's session, which internally tracks user actions on a photo.
    __block AFPhotoEditorSession *session = [photoEditor session];
    
    // Add the session to our sessions array. We need to retain the session until all contexts we create from it are finished rendering.
    [[self sessions] addObject:session];
    
    // Create a context from the session with the high res image.
    AFPhotoEditorContext *context = [session createContextWithImage:highResImage];
    
    __block GlideViewController * blockSelf = self;
    
    // Call render on the context. The render will asynchronously apply all changes made in the session (and therefore editor)
    // to the context's image. It will not complete until some point after the session closes (i.e. the editor hits done or
    // cancel in the editor). When rendering does complete, the completion block will be called with the result image if changes
    // were made to it, or `nil` if no changes were made. In this case, we write the image to the user's photo album, and release
    // our reference to the session.
    [context render:^(UIImage *result) {
        if (result) {
            UIImageWriteToSavedPhotosAlbum(result, nil, nil, NULL);
        }
        
        [[blockSelf sessions] removeObject:session];
        
        blockSelf = nil;
        session = nil;
        
    }];
}

#pragma Photo Editor Delegate Methods

// This is called when the user taps "Done" in the photo editor.
- (void) photoEditor:(AFPhotoEditorController *)editor finishedWithImage:(UIImage *)image
{
    GlideModel *data = [[GlideModel alloc] init];
    data.image = image;
    data.caption = @"";
    data.videoURL = @"";
    
    if (self.glideData == nil)
    {
        self.glideData = [[NSMutableArray alloc] initWithObjects:data, nil];
    }
    
    else
    {
        [self.glideData addObject: data];
    }
    
    [self.myTableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

// This is called when the user taps "Cancel" in the photo editor.
- (void) photoEditorCanceled:(AFPhotoEditorController *)editor
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Photo Editor Customization

- (void) setPhotoEditorCustomizationOptions
{
    // Set Tool Order
    NSArray * toolOrder = @[kAFEffects, kAFFocus, kAFFrames, kAFStickers, kAFEnhance, kAFOrientation, kAFCrop, kAFAdjustments, kAFSplash, kAFDraw, kAFText, kAFRedeye, kAFWhiten, kAFBlemish, kAFMeme];
    [AFPhotoEditorCustomization setToolOrder:toolOrder];
    
    // Set Custom Crop Sizes
    [AFPhotoEditorCustomization setCropToolOriginalEnabled:NO];
    [AFPhotoEditorCustomization setCropToolCustomEnabled:YES];
    NSDictionary * fourBySix = @{kAFCropPresetHeight : @(4.0f), kAFCropPresetWidth : @(6.0f)};
    NSDictionary * fiveBySeven = @{kAFCropPresetHeight : @(5.0f), kAFCropPresetWidth : @(7.0f)};
    NSDictionary * square = @{kAFCropPresetName: @"Square", kAFCropPresetHeight : @(1.0f), kAFCropPresetWidth : @(1.0f)};
    [AFPhotoEditorCustomization setCropToolPresets:@[fourBySix, fiveBySeven, square]];
    
    // Set Supported Orientations
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        NSArray * supportedOrientations = @[@(UIInterfaceOrientationPortrait), @(UIInterfaceOrientationPortraitUpsideDown), @(UIInterfaceOrientationLandscapeLeft), @(UIInterfaceOrientationLandscapeRight)];
        [AFPhotoEditorCustomization setSupportedIpadOrientations:supportedOrientations];
    }
}


#pragma mark - UIImagePicker Delegate

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSURL * assetURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    void(^completion)(void)  = ^(void){
        
        [[self assetLibrary] assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            if (asset){
                [self launchEditorWithAsset:asset];
            }
        } failureBlock:^(NSError *error) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enable access to your device's photos." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }];
    };
    
    [self dismissViewControllerAnimated:YES completion:completion];}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ALAssets Helper Methods

- (UIImage *)editingResImageForAsset:(ALAsset*)asset
{
    CGImageRef image = [[asset defaultRepresentation] fullScreenImage];
    
    return [UIImage imageWithCGImage:image scale:1.0 orientation:UIImageOrientationUp];
}

- (UIImage *)highResImageForAsset:(ALAsset*)asset
{
    ALAssetRepresentation * representation = [asset defaultRepresentation];
    
    CGImageRef image = [representation fullResolutionImage];
    UIImageOrientation orientation = [representation orientation];
    CGFloat scale = [representation scale];
    
    return [UIImage imageWithCGImage:image scale:scale orientation:orientation];
}




#pragma mark - Private Helper Methods

- (BOOL) hasValidAPIKey
{
    NSString * key = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Aviary-API-Key"];
    if ([key isEqualToString:@"<YOUR_API_KEY>"]) {
        [[[UIAlertView alloc] initWithTitle:@"Oops!" message:@"You forgot to add your API key!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return NO;
    }
    return YES;
}

- (IBAction)choosePhoto:(id)sender {
    
    if ([self hasValidAPIKey]) {
        UIImagePickerController * imagePicker = [UIImagePickerController new];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        [imagePicker setDelegate:self];
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (IBAction)glideStory:(id)sender {
    
    if (self.glideData != nil && self.glideData.count > 0 && storyTitleField.text.length > 0)
    {
        
        NSURL *url = [NSURL URLWithString:@"http://paperv.com/api/add_story.php"];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *user_id = [defaults objectForKey:@"user_id"];
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:user_id forKey:@"user_id"];
        [request setPostValue:@"1" forKey:@"category_id"];
        [request setPostValue:storyTitleField.text forKey:@"title"];
        
        NSString *videos = @"";
        NSString *videoCaptions = @"";
        NSString *imageCaptions = @"";
        NSInteger imageIndex = 0;
        
        for (NSInteger index = 0; index < self.glideData.count; index++) {
            
            GlideModel* data = self.glideData[index];
            
            if (data.videoURL.length > 0) {
                videos = [videos stringByAppendingString:data.videoURL];
                videos = [videos stringByAppendingString:@","];
                
                videoCaptions = [videoCaptions stringByAppendingString:data.caption];
                videoCaptions = [videoCaptions stringByAppendingString:@","];
            }
            
            else
            {
                // get all images
                NSData *imageData = UIImageJPEGRepresentation(data.image, 1.0);
                [request setData:imageData withFileName:[NSString stringWithFormat:@"myphoto%f.jpg",[[NSDate date] timeIntervalSince1970]] andContentType:@"image/*" forKey:[NSString stringWithFormat:@"image[%d]",imageIndex++]];
                
                
                imageCaptions = [imageCaptions stringByAppendingString:data.caption];
                imageCaptions = [imageCaptions stringByAppendingString:@","];
            }
            
        }
    
//        https://www.youtube.com/watch?v=K2EAYacKz7c
        
        
        NSString *captions = [imageCaptions stringByAppendingString:videoCaptions];
        
        if ( [captions length] > 0)
            captions = [captions substringToIndex:[captions length] - 1];
        [request setPostValue:captions forKey:@"captions"];
        
        
        if ( [videos length] > 0)
            videos = [videos substringToIndex:[videos length] - 1];
        [request setPostValue:videos forKey:@"videos"];

        
        
        [request startAsynchronous];
        
        [self.glideData removeAllObjects];
        [self.myTableView reloadData];
        storyTitleField.text = @"";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"PaperV" message:@"Story Glided Successfully." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];
    }
    
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"PaperV" message:@"Incomplete data." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];
    }
}

- (IBAction)addVideo:(id)sender {
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"PaperV!" message:@"Please enter your video link:" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    //    alertTextField.keyboardType = UIKeyboardTypeNumberPad;
    alertTextField.placeholder = @"Youtube url ...";
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ([[[alertView textFieldAtIndex:0] text] length] > 0)
    {
        GlideModel *data = [[GlideModel alloc] init];
        data.image = nil;
        data.caption = @"";
        data.videoURL = [[alertView textFieldAtIndex:0] text];
        
        if (self.glideData == nil)
        {
            self.glideData = [[NSMutableArray alloc] initWithObjects:data, nil];
        }
        
        else
        {
            [self.glideData addObject: data];
        }
        
        [self.myTableView reloadData];
    }
}
@end
