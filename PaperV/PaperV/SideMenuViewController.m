//
//  SideMenuViewController.m
//  PaperV
//
//  Created by mac on 11/27/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import "SideMenuViewController.h"
#import "AsyncImageView.h"
#import "TabBarViewController.h"
#import "TWTSideMenuViewController.h"

@interface SideMenuViewController ()
{
    UIStoryboard *storyboard;
}

@end

@implementation SideMenuViewController

@synthesize avatar;
@synthesize userName;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"SideMenuBackground"]]];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    userName.text = [defaults objectForKey:@"full_name"];
    
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


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (IBAction)openHome:(id)sender {
    
    [self.sideMenuViewController setMainViewController:[storyboard instantiateViewControllerWithIdentifier:@"TabViewController"] animated:YES closeMenu:YES];
}

- (IBAction)openAbout:(id)sender {
    
       [self.sideMenuViewController setMainViewController:[storyboard instantiateViewControllerWithIdentifier:@"AboutViewController"] animated:YES closeMenu:YES];
    
}

- (IBAction)openPrivacy:(id)sender {
    
    [self.sideMenuViewController setMainViewController:[storyboard instantiateViewControllerWithIdentifier:@"PrivacyViewController"] animated:YES closeMenu:YES];
}

- (IBAction)openTerms:(id)sender {
    
    [self.sideMenuViewController setMainViewController:[storyboard instantiateViewControllerWithIdentifier:@"TermsViewController"] animated:YES closeMenu:YES];
}

- (IBAction)openContact:(id)sender {
    
    [self.sideMenuViewController setMainViewController:[storyboard instantiateViewControllerWithIdentifier:@"ContactViewController"] animated:YES closeMenu:YES];
}

- (IBAction)logout:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"" forKey:@"user_name"];
    [defaults synchronize];
    
    [self.sideMenuViewController setMainViewController:[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"] animated:YES closeMenu:YES];
    
}
@end
