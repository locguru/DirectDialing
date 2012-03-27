//
//  SettingsTabViewController.m
//  DirectDialing
//
//  Created by Itai Ram on 12/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsTabViewController.h"
#import "FlurryAnalytics.h"

@implementation SettingsTabViewController

@synthesize textField;
@synthesize nameTextField;
@synthesize firstName;
@synthesize lastName;
@synthesize number;
@synthesize accessNumberName;
@synthesize delegate;
@synthesize tblSimpleTable;
@synthesize listOfItems;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:1];
        number = [[NSString alloc] init];
        accessNumberName = [[NSString alloc] init];
        listOfItems = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.title = @"Direct Dialing";
    self.title = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    self.view.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"smartphonebackground.png"]];
    
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
    
    //TEXT FIELD
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(150, 5, 155, 35)];
    nameTextField.adjustsFontSizeToFitWidth = YES;
    nameTextField.textColor = [UIColor blackColor];
    nameTextField.backgroundColor = [UIColor whiteColor];
    nameTextField.font = [UIFont systemFontOfSize:15];
    nameTextField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
    nameTextField.textAlignment = UITextAlignmentLeft;
    nameTextField.placeholder = NSLocalizedString(@"ContactName", nil);
    nameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    nameTextField.keyboardType = UIKeyboardTypeEmailAddress; // UIKeyboardTypePhonePad;
    nameTextField.returnKeyType = UIReturnKeyNext;
    nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;    
    [nameTextField setEnabled: YES];
    nameTextField.delegate = self;
 //   [self.view addSubview:nameTextField];

    textField = [[UITextField alloc] initWithFrame:CGRectMake(150, 5, 155, 35)];
    textField.adjustsFontSizeToFitWidth = YES;
    textField.textColor = [UIColor blackColor];
    textField.backgroundColor = [UIColor whiteColor];
    textField.font = [UIFont systemFontOfSize:15];
    textField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
    textField.textAlignment = UITextAlignmentLeft;
    textField.placeholder = NSLocalizedString(@"AccessNumber", nil);
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.keyboardType = UIKeyboardTypePhonePad; // UIKeyboardTypePhonePad;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; 
    [textField setEnabled: YES];
    textField.delegate = self;
//    [self.view addSubview:textField];
    
    //CREATING UITABLEVIEW 
    tblSimpleTable = [[UITableView alloc]  initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped ];
    tblSimpleTable.scrollEnabled = YES;
    tblSimpleTable.backgroundColor = [UIColor clearColor];
    tblSimpleTable.dataSource = self;
    tblSimpleTable.delegate = self;
    [self.view addSubview:tblSimpleTable];

    listOfItems = [NSMutableArray arrayWithObjects:NSLocalizedString(@"ContactNameCaps", nil), NSLocalizedString(@"AccessNumberCaps", nil), nil];
        
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
    [FlurryAnalytics logEvent:@"CLICKED ON CANCEL"];
    [self dismissModalViewControllerAnimated:YES];
}

//- (IBAction)dismissScreen:(id)sender 
//{
//    [self dismissModalViewControllerAnimated:YES];
//}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [FlurryAnalytics logEvent:@"START EDITING IN ADD ACCESS NUMBER SCREEN"];
    NSLog(@"****************** START EDITING IN ADD ACCESS NUMBER SCREEN");
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    self.navigationItem.leftBarButtonItem.enabled = NO;
}

- (IBAction)dismissKeyboard:(UITextField *)textField1 {
 
     [FlurryAnalytics logEvent:@"USER DISMISSES KEYBOARD"];
    
    [textField resignFirstResponder];        
    [nameTextField resignFirstResponder];
    
    number = textField.text;
    accessNumberName = nameTextField.text;

    //Adding new info to main view controller 
    [self.delegate refreshTableView:number:accessNumberName];
    
    self.navigationItem.leftBarButtonItem.enabled = YES;
    self.navigationItem.rightBarButtonItem = nil;
    
    UIBarButtonItem *continueButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Continue", nil) style:UIBarButtonItemStyleDone target:self action:@selector(continueView:)];
    self.navigationItem.rightBarButtonItem = continueButton;
}

- (IBAction)continueView:(id)sender 
{
    [FlurryAnalytics logEvent:@"CLICK ON 'CONTINUE' - LEAVING SECOND SCREEN"];
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

    if (textField1 == nameTextField) {
        [textField becomeFirstResponder];        
        
    } else {
        [nameTextField resignFirstResponder];
    }   
    
    return NO;
}


//***** TABLE VIEW DELEGATE METHODS *****//

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
            
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier]; //try here diff styles        
    }

    NSString *cellValue = [[NSString alloc] init];
    cellValue = [listOfItems objectAtIndex:indexPath.row];
    cell.textLabel.text = cellValue;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.backgroundColor = [UIColor whiteColor];
        
    if ([indexPath row] == 0) { 
        [cell addSubview:nameTextField]; 
       // [nameTextField becomeFirstResponder];

    }
    else {
        [cell addSubview:textField]; 
    }

    return cell;
}

//
//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return indexPath;
//}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        
        return NSLocalizedString(@"EnterAccessNumber", nil);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listOfItems count];   
}

- (NSString *)tableView:(UITableView *)tv titleForFooterInSection:(NSInteger)section
{
    return NSLocalizedString(@"EnterInstructions", nil);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ;
}

@end
