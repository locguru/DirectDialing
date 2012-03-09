//
//  SettingsTabViewController.m
//  DirectDialing
//
//  Created by Itai Ram on 12/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsTabViewController.h"
#import <AddressBook/AddressBook.h>
#import "AccessNumber.h"

@implementation SettingsTabViewController

@synthesize textField;
@synthesize firstName;
@synthesize lastName;
@synthesize number;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       // self.title = @"Settings";
        self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:1];
        number = [[NSString alloc] init];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Direct Dialing";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

////    UIButton *testb = [[UIButton alloc] init];
////    testb.frame = CGRectMake(40, 140, 240, 30);
//    
////    testb = [UIButton buttonWithType:UIButtonTypeRoundedRect]; 
//    testb.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:testb];

    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelView:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
//    UIBarButtonItem *doneButton1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissScreen:)];
//    self.navigationItem.rightBarButtonItem = doneButton1;


    //LABELS
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 280, 20)];
	myLabel.text = @"Enter your access number:";
	myLabel.backgroundColor = [UIColor clearColor]; // [UIColor brownColor];
    myLabel.font = [UIFont boldSystemFontOfSize:16];;
    myLabel.textColor =  [UIColor colorWithRed:0.265 green:0.294 blue:0.367 alpha:1.0];
    myLabel.shadowColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    myLabel.shadowOffset = CGSizeMake(0, 1);
	[self.view addSubview:myLabel];

    
    
	[self.view addSubview:myLabel];
    
//    UILabel *myLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(140, 150, 280, 40)];
//	myLabel1.text = @"OR";
//	myLabel1.backgroundColor = [UIColor clearColor]; // [UIColor brownColor];
//    myLabel1.font = [UIFont systemFontOfSize:14];
//	[self.view addSubview:myLabel1];
//
//    UILabel *myLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 220, 280, 40)];
//	myLabel2.text = @"Select from address book";
//	myLabel2.backgroundColor = [UIColor clearColor]; // [UIColor brownColor];
//    myLabel2.font = [UIFont systemFontOfSize:14];
//	[self.view addSubview:myLabel2];

    
    //TEXT FIELD
    textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 70, 300, 40)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:15];
    textField.placeholder = @"your access number";
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.keyboardType = UIKeyboardTypePhonePad; // UIKeyboardTypePhonePad;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;    
    textField.delegate = self;
    [self.view addSubview:textField];


//    //ADDING DIAL BUTTON
//    UIButton *dialButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [dialButton addTarget:self action:@selector(showPicker:) forControlEvents:UIControlEventTouchUpInside];
//    dialButton.frame = CGRectMake(70, 280, 180, 40.0);
//    dialButton.contentMode = UIViewContentModeScaleToFill;
//    [self.view addSubview:dialButton];
}

- (IBAction)showPicker:(id)sender 
{
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    
    [self presentModalViewController:picker animated:YES];
}

- (IBAction)cancelView:(id)sender 
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)dismissScreen:(id)sender 
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard:)];
    self.navigationItem.rightBarButtonItem = doneButton;

    self.navigationItem.leftBarButtonItem.enabled = NO;
}

- (IBAction)dismissKeyboard:(id)sender{
    
    [textField resignFirstResponder];
    
    number = textField.text;

    NSLog(@"number: %@", number);
    NSLog(@"textField1 is: %@", textField.text);
    
    [self.delegate refreshTableView:number];

//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];            
//    [defaults setObject:textField.text forKey:@"accessNumber"];

    self.navigationItem.leftBarButtonItem.enabled = YES;
    self.navigationItem.rightBarButtonItem = nil;
    
    UIBarButtonItem *continueButton = [[UIBarButtonItem alloc] initWithTitle:@"Continue" style:UIBarButtonItemStyleDone target:self action:@selector(continueView:)];
    self.navigationItem.rightBarButtonItem = continueButton;

}

- (IBAction)continueView:(id)sender 
{
    NSLog(@"entering continueView disimssing manual number ");
    [self dismissModalViewControllerAnimated:YES];
}


- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
//    NSString* name = (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
//    NSString *name = [[NSString alloc] init];
//    ABMultiValueRef *phones = (ABMultiValueRef *) ABRecordCopyValue(person, kABPersonFirstNameProperty);
    
//    CFStringRef name = (CFStringRef)ABRecordCopyValue(person, kABPersonFirstNameProperty);
//    
//    NSLog(@"self.firstName.text is: %@", name);
//    
//    self.lastName.text = (__bridge_transfer  NSString *) name;
//    
//    NSLog(@"self.firstName.text is: %@", self.lastName.text);

    
    NSString* name = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    
    NSString *temp = [[NSString alloc] init];
    
    temp = name;
    
    self.lastName.text = name;
    
    
    NSLog(@"self.firstName.text is: %@", self.lastName.text);
    NSLog(@"temp is: %@", temp);
    NSLog(@"name is: %@", name);
    
//    name = ( NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
//    self.firstName.text = name;
//    
//    NSLog(@"self.firstName.text is: %@", self.firstName.text);
//
//    name = (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
//    self.lastName.text = name;
//    
//    NSLog(@" self.lastName.text is: %@",  self.lastName.text);
//
    [self dismissModalViewControllerAnimated:YES];
    
    return NO;
}

- (void)peoplePickerNavigationControllerDidCancel: (ABPeoplePickerNavigationController *)peoplePicker 
{    
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField1 {
    
    [textField1 resignFirstResponder];
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ;
}

@end
