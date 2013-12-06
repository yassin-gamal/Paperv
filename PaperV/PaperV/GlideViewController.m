//
//  GlideViewController.m
//  PaperV
//
//  Created by mac on 11/23/13.
//  Copyright (c) 2013 Triangles. All rights reserved.
//

#import "GlideViewController.h"
#import "TWTSideMenuViewController.h"
#import "CustomCell.h"

@interface GlideViewController ()

@end

@implementation GlideViewController

@synthesize myScrollView;
@synthesize myPicker;
@synthesize colorArray;

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
    
    
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.transform = CGAffineTransformMakeRotation(M_PI/-2);
    
    storyTitleField.delegate = self;
    
    
    myScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [[self myScrollView] setScrollEnabled:YES];
    [[self myScrollView] setContentSize:CGSizeMake(320, 800)];
    
    self.colorArray  = [[NSArray alloc] initWithObjects:@"Category",@"Blue",@"Green",@"Orange",@"Purple",@"Red",@"Yellow" , nil];
    
    myPicker.delegate = self;
    myPicker.dataSource = self;
    
    UIImage *image = [UIImage imageNamed:@"Yehia"];
    [avatar setImage:image];
    avatar.layer.cornerRadius = avatar.frame.size.width / 2;
    avatar.layer.masksToBounds = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [storyTitleField resignFirstResponder];
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



- (IBAction)showActionSheet:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    [actionSheet setBackgroundColor:[UIColor whiteColor]];

    
    CGRect pickerFrame = CGRectMake(0, 0, 300, 0);
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [pickerView setBackgroundColor:[UIColor whiteColor]];
    
    [actionSheet addSubview:pickerView];
    
    
    
    
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
    toolBar.barStyle = UIBarStyleDefault;
    [toolBar setBackgroundColor:[UIColor colorWithRed:81.0/255 green:196.0/255 blue:212.0/255 alpha:1.0]];
    [actionSheet addSubview:toolBar];
    
    
    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
    closeButton.momentary = YES;
    closeButton.frame = CGRectMake(240, 7.0f, 50.0f, 30.0f);
    closeButton.tintColor = [UIColor colorWithRed:81.0/255 green:196.0/255 blue:212.0/255 alpha:1.0];
    [closeButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:closeButton];
    [actionSheet showInView:self.view];//[UIApplication mainWindow]];
    [actionSheet setBounds:CGRectMake(0, 0, 300, 380)];}

-(void) dismissActionSheet:(id)sender {
    UIActionSheet *actionSheet =  (UIActionSheet *)[(UIView *)sender superview];
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return 7;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    
    return [self.colorArray objectAtIndex:row];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component{
    
    NSLog(@"Selected Row %d", row);
    switch(row)
    {
            
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;
    }
    
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.contentView.transform = CGAffineTransformMakeRotation(M_PI/2);
    }
    
     cell.contentView.transform = CGAffineTransformMakeRotation(M_PI/2);
        
    // Configure the cell...
    
    return cell;
}



@end
