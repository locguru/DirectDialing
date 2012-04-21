//
//  AccessNumber.m
//  DirectDialing
//
//  Created by Itai Ram on 12/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AccessNumber.h"
#import "ViewController.h"
#import "SettingsTabViewController.h"
#import "History.h"
#import "FlurryAnalytics.h"
#import "Settings.h"


@implementation AccessNumber

@synthesize selectedAccessNumber;
@synthesize directNumber;
@synthesize manualDial;
@synthesize selectNumber;
@synthesize tblSimpleTable;
@synthesize listOfItems;
@synthesize mainScrollView;
@synthesize accessNumbers;
@synthesize numDataObj;
@synthesize firstName;
@synthesize lastName;
@synthesize phoneNumber;
@synthesize fullNumber;
@synthesize accessObj;
@synthesize lastIndexPath;
@synthesize cellLabel1;
@synthesize cellLabel2;

//@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        selectedAccessNumber = [[NSString alloc] initWithString:@""];
        directNumber = [[NSString alloc] initWithString:@""];
        manualDial = [[UIButton alloc] init];
        selectNumber = [[UIButton alloc] init];
        accessNumbers = [[NSMutableArray alloc] initWithObjects:nil];
        firstName = [[NSString alloc] initWithString:@""];
        lastName = [[NSString alloc] initWithString:@""];
        phoneNumber = [[NSString alloc] initWithString:@""];
        fullNumber = [[NSString alloc] initWithString:@""];
        accessObj = [[NumberDataObj alloc] init];
        cellLabel1 = [[UILabel alloc] init];
        cellLabel2 = [[UILabel alloc] init];
        //numDataObj = [[NumberDataObj alloc] init];
        numDataObj = [[NumberDataObj alloc] init];
        lastIndexPath = [[NSIndexPath alloc] init];
    }
    return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //NAVIGATION BAR
    //self.title = @"Direct Dialing";
    self.title = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    self.view.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"smartphonebackground.png"]];

    //left BUTTON 
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Options" style:UIBarButtonItemStylePlain target:self action:@selector(SettingsVC:)];      
    self.navigationItem.leftBarButtonItem = leftButton;
    
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"History" style:UIBarButtonItemStylePlain target:self action:@selector(history:)];      
//    self.navigationItem.leftBarButtonItem = leftButton;
    //    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = nil;
    
    cellLabel1.text = NSLocalizedString(@"AccessNumberName", nil);
    cellLabel2.text = NSLocalizedString(@"AccessNumber", nil);
    
    //ADDING BACKGROUND IMAGE 
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
////    imgView.image = [UIImage imageNamed:@"smartphonebackground.png"];
//    imgView.image = [UIImage imageNamed:@"caller-background.png"];
//
//    [self.view addSubview: imgView];
//    [self.view sendSubviewToBack:imgView];
    
    //CREATING UITABLEVIEW 
    tblSimpleTable = [[UITableView alloc]  initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped ];

    NSLog(@"self.view.frame.size.width is %@", self.view.frame.size.width);
    NSLog(@"self.view.frame.size.height is %@", self.view.frame.size.height);
    
 //   tblSimpleTable = [[UITableView alloc] init];
//    tblSimpleTable.backgroundColor = [UIColor clearColor];
     tblSimpleTable.scrollEnabled = YES;
//    tblSimpleTable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"smartphonebackground.png"]];
    tblSimpleTable.backgroundColor = [UIColor clearColor];

//   tblSimpleTable.bounces = YES;
    tblSimpleTable.dataSource = self;
    tblSimpleTable.delegate = self;
    [self.view addSubview:tblSimpleTable];
 //   [mainView addSubview:tblSimpleTable];

    //LOAD DATA FROM NSUSERDEFAULTS
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];     
    NSData *archivedSavedData = [[NSData alloc] init];    
    NSData *archivedlastIndexPath = [[NSData alloc] init];    

    archivedSavedData = [defaults dataForKey:@"listOfAccessNumbers"];
    archivedlastIndexPath = [defaults dataForKey:@"lastIndexPath"];
    accessNumberChecked = [defaults boolForKey:@"accessNumberChecked"];
    
    lastIndexPath = [NSKeyedUnarchiver unarchiveObjectWithData:archivedlastIndexPath];
    
    //NSNumber *number = [defaults objectForKey:@"lastIndexPathRow"];

    if ([archivedSavedData length] == 0 ){

   //     NSLog(@"archivedSavedData is nil");
    }
    //Unarchieve 
    else  
    {
        NSMutableArray *savedArray = [[NSMutableArray alloc] init];
        savedArray = [NSKeyedUnarchiver unarchiveObjectWithData:archivedSavedData];
        accessNumbers = savedArray;
    }
    
    //DONT SHOW EDIT BUTTON ON NAV BAR IF THERE ARE NO ACCESS NUMBERS
    if (accessNumbers == NULL || [accessNumbers count] == 0 )
    {
        self.navigationItem.rightBarButtonItem = nil;
        sectionIndicator = NO;
        accessNumbers = [[NSMutableArray alloc] initWithObjects:nil];
    }
    else
    {
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
        sectionIndicator = YES;
    }
    
    //INITIALIZING DATA SOURCE
    listOfItems = [[NSMutableArray alloc] init];
    NSMutableArray *addNewAccessNumberLabel = [NSMutableArray arrayWithObjects:NSLocalizedString(@"AddNewAccessNumber", nil), nil];
    NSMutableArray *launchABArray = [NSMutableArray arrayWithObjects:NSLocalizedString(@"AddressBook", nil), nil];

    //ADDING ACCESS NUMBER SECTION TO THE DATA SOURCE ONLY IF NOT EMPTY
    if (sectionIndicator == YES) {
        [listOfItems addObject:accessNumbers];
    }
    
    [listOfItems addObject:addNewAccessNumberLabel];
    [listOfItems addObject:launchABArray];

    
}


//UI METHODS
- (IBAction)addAccessNumber:(id)sender {  
    
    [FlurryAnalytics logEvent:@"Enter addAccessNumber method"];

    SettingsTabViewController *addNewAccessNumberVC = [[SettingsTabViewController alloc] initWithNibName:nil bundle:nil];
    addNewAccessNumberVC.delegate = self;
    UINavigationController *addNewAccessNumberVCNav = [[UINavigationController alloc] initWithRootViewController:addNewAccessNumberVC];
    addNewAccessNumberVCNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;    
    [self presentModalViewController:addNewAccessNumberVCNav animated:YES];

}

- (IBAction)launchDialer:(id)sender {  
    
    [FlurryAnalytics logEvent:@"LAUCNING DIALER"];
    
    ViewController *dialerController = [[ViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *dialerControllerNav = [[UINavigationController alloc] initWithRootViewController:dialerController];
    dialerControllerNav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;    
    [self presentModalViewController:dialerControllerNav animated:YES];
}

- (IBAction)launchAB:(id)sender{
    
    [FlurryAnalytics logEvent:@"LAUNCHING ADDRESS BOOK"];
    
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    [self presentModalViewController:picker animated:YES];
}

- (IBAction)history:(id)sender {  
    
     [FlurryAnalytics logEvent:@"LAUNCHING HISTORY"];
    
//    History *historytemp = [[History alloc] initWithNibName:@"History" bundle:[NSBundle mainBundle]];
//    [historytemp setDelegate:self];
//    
//    UINavigationController *historyNavigationController = [[UINavigationController alloc] initWithRootViewController:historytemp];
//    historyNavigationController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;    
//    [self presentModalViewController:historyNavigationController animated:YES];


    History *historyViewController = [[History alloc] initWithNibName:nil bundle:nil];
    UINavigationController *historyNavigationController = [[UINavigationController alloc] initWithRootViewController:historyViewController];
    historyNavigationController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;    
    [self presentModalViewController:historyNavigationController animated:YES];
}

-(IBAction)SettingsVC:(id)sender {
    
    [FlurryAnalytics logEvent:@"CLICK ON SETTINGS"];
    
    Settings *SettingsVC = [[Settings alloc] initWithNibName:nil bundle:nil];
    UINavigationController *SettingsNavigationController = [[UINavigationController alloc] initWithRootViewController:SettingsVC];
    SettingsNavigationController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;    
    [self presentModalViewController:SettingsNavigationController animated:YES];

    
//    //ACTION SHEET
//    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Share and Contact Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Share on Facebook", @"Post to Twitter", @"Contact Us", nil];  
////    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Post to Facebook", @"Share on Twitter", @"Contact Us", nil];  
//
//    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
//    [popupQuery showInView:self.view];    
}


//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
//{
//
//}



//***** PHONE DIAL METHOD METHOD *****//

- (IBAction)dialNumber:(NSString *)phoneNum {
    
    NSMutableString *strippedString = [NSMutableString stringWithCapacity:phoneNumber.length];
    NSScanner *scanner = [NSScanner scannerWithString:phoneNumber];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    while ([scanner isAtEnd] == NO) {
        NSString *buffer;
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer]) {
            [strippedString appendString:buffer];
            
        } else {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
    }
    
    NSLog(@"fullNumber %@", fullNumber);
    NSLog(@"accessNumber %@", accessObj.inputName);
    NSLog(@"phoneNumber %@", phoneNumber);
    NSLog(@"accessObj.inputNum %@", accessObj.inputNum);


    
    fullNumber = [NSString stringWithFormat:@"%@%@%@%@", @"tel:", accessObj.inputNum, @",", strippedString];
    NSString *myMessage = [NSString stringWithFormat:NSLocalizedString(@"DialingConfirmation", nil), phoneNumber , accessObj.inputNum];
    UIAlertView *alert;
    
    NSLog(@"accessObj.inputNu %@", accessObj.inputNum);
    NSLog(@"phoneNumber %@", phoneNumber);

    
    if( accessNumberChecked == NO | [phoneNumber length] == 0 )
    {
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:myMessage, @"My Message", nil];
        [FlurryAnalytics logEvent:@"MISSING ACCESS NUMBER ALERT" withParameters:dictionary];
        
        alert = [[UIAlertView alloc] initWithTitle:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"] 
                                                        message:NSLocalizedString(@"EnterAccessNumberAndTryAgain", nil)
                                                       delegate:self 
                                              cancelButtonTitle:NSLocalizedString(@"Ok", nil) 
                                              otherButtonTitles:nil, nil];
 
    }
    else
    {
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:myMessage, @"My Message", nil];
        [FlurryAnalytics logEvent:@"CONFIRM DIALING ALERT" withParameters:dictionary];

        alert = [[UIAlertView alloc] initWithTitle:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"] 
                                       message:myMessage
                                      delegate:self 
                             cancelButtonTitle:NSLocalizedString(@"Cancel", nil) 
                             otherButtonTitles:NSLocalizedString(@"Ok", nil), nil];
    }
    
    [alert show];
}


- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 0)
    {       
        NSLog(@"cancel");
    }
    else
    {
        NSLog(@"ok");
        NSURL *url = [NSURL URLWithString:fullNumber];
        [[UIApplication sharedApplication] openURL:url];
   //     [self dismissModalViewControllerAnimated:YES];    

    }
}

//***** CUSTOME TABLE METHOD *****//

- (void)refreshTableView:(NSString *) trasnferedNumber:(NSString *) transferedNumberName{

    //Adding data to history
  //  [[self delegate] processSuccessful];

    
//    NSLog(@"entering refreshTableView");
//    NSLog(@"transferedNumberName %@", transferedNumberName);
//    NSLog(@"Process completed");
//    NSLog(@"listOfItems %@", listOfItems);    
//    NSLog(@"trasnferedNumber.length: %d", trasnferedNumber.length);

    NSLog(@"trasnferedNumber %@", trasnferedNumber);

    numDataObj = [[NumberDataObj alloc] init];
    
    if (trasnferedNumber.length != 0) 
    {        
        
        //REMOVE ALL NON DIGITS FROM INPUT NUMBER
        
        NSString *newString = [[trasnferedNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
        NSLog(@"newString %@", newString);
        trasnferedNumber = newString;

        
        
        if (trasnferedNumber.length < 9)
        {
            NSString *formattedString = trasnferedNumber;
            numDataObj.inputName = transferedNumberName;
            numDataObj.inputNum = formattedString;
            
         //   [accessNumbers addObject:formattedString];
            [accessNumbers addObject:numDataObj];
            NSLog(@"numDataObj %@", numDataObj);

            
        }
        else
        {
            NSArray *stringComponents = [NSArray arrayWithObjects:[trasnferedNumber substringWithRange:NSMakeRange(0, 3)], 
                                         [trasnferedNumber substringWithRange:NSMakeRange(3, 3)], 
                                         [trasnferedNumber substringWithRange:NSMakeRange(6, [trasnferedNumber length]-6)], nil];
            NSString *formattedString = [NSString stringWithFormat:@"%@-%@-%@", [stringComponents objectAtIndex:0], [stringComponents objectAtIndex:1], [stringComponents objectAtIndex:2]];

            numDataObj.inputName = transferedNumberName;
            numDataObj.inputNum = formattedString;
            [accessNumbers addObject:numDataObj];

        }

        //Saving/Updating NSUserDefaults 
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:accessNumbers];
       [defaults setObject:data forKey:@"listOfAccessNumbers"];    
         
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
        
        if (sectionIndicator == NO)
        {
            [listOfItems insertObject:accessNumbers atIndex:0];
            sectionIndicator = YES;
        }
     
        [tblSimpleTable reloadData];
    }
    //else do nothing

}

//***** ADDRESS BOOK DELEGATE METHODS *****//

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{

//    NSLog(@"****************** entering peoplePickerNavigationController");

    NSString* name = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    self.firstName = name;
    NSLog(@"first name is: %@", name);
    name = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    self.lastName = name;
    NSLog(@"last name is: %@", name);

    
    if (property == kABPersonPhoneProperty) {
        ABMultiValueRef multiPhones = ABRecordCopyValue(person, kABPersonPhoneProperty);
        for(CFIndex i = 0; i < ABMultiValueGetCount(multiPhones); i++) {
            if(identifier == ABMultiValueGetIdentifierAtIndex (multiPhones, i)) {
                CFStringRef phoneNumberRef = ABMultiValueCopyValueAtIndex(multiPhones, i);
                CFRelease(multiPhones);
                phoneNumber = (__bridge NSString *) phoneNumberRef;
                CFRelease(phoneNumberRef);
                //txtPhoneNumber.text = [NSString stringWithFormat:@"%@", phoneNumber];
                NSLog(@" phoneNumber is: %@", phoneNumber);
            }
        }
    }
    
    [self dismissModalViewControllerAnimated:YES];    
    
    [self dialNumber:phoneNumber];
    return NO;
}

- (void)peoplePickerNavigationControllerDidCancel: (ABPeoplePickerNavigationController *)peoplePicker {
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    return YES;
}

//***** TABLE VIEW DELEGATE METHODS *****//

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  //  NSLog(@"****************** entering cellForRowAtIndexPath at Section %d", indexPath.section);

   // static NSString *CellIdentifier = @"Cell";
    
    static NSString *CellIdentifier1 = @"Cell_Section_1";
	static NSString *CellIdentifier2 = @"Cell_Section_2";
    UITableViewCell *cell;
    
    //3 Sections
    if ( sectionIndicator == YES ) 
    {
        if (indexPath.section == 0) 
        {      
            cell = [self getCellContentView:CellIdentifier2];
            cellLabel1 = (UILabel *)[cell viewWithTag:1];
            cellLabel2 = (UILabel *)[cell viewWithTag:2];

            NSArray *array = [[NSArray alloc] init];
            array = [listOfItems objectAtIndex:indexPath.section];
            
            NumberDataObj *tempObj = [[NumberDataObj alloc] init];
            tempObj = [array objectAtIndex:indexPath.row];
            cellLabel1.text = tempObj.inputName;
            cellLabel2.text = tempObj.inputNum;
            
            if (lastIndexPath != nil){
                if (indexPath.row == lastIndexPath.row && accessNumberChecked == YES)
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            
        }   
        else //sections 1 and 2
        {    
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1]; 
            NSArray *array = [[NSArray alloc] init];
            array = [listOfItems objectAtIndex:indexPath.section];
            cell.textLabel.text = [array objectAtIndex:indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = [UIColor colorWithRed:.196 green:0.3098 blue:0.52 alpha:1.0];
        }
    }
    //2 Sections
    else
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1]; 
        NSArray *array = [[NSArray alloc] init];
        array = [listOfItems objectAtIndex:indexPath.section];
        cell.textLabel.text = [array objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithRed:.196 green:0.3098 blue:0.52 alpha:1.0];

    }
    
    //Determine accessory touch selection 
    if (sectionIndicator == YES){

        if (indexPath.section == 0) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else if (indexPath.section == 1) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    else
    {
        if (indexPath.section == 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    return cell;
}


- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier {
	
   // NSLog(@"****************** entering getCellContentView");
    
 //   CGRect CellFrame = CGRectMake(0, 0, 300, 60);
	CGRect Label1Frame = CGRectMake(10, 10, 290, 20);
	CGRect Label2Frame = CGRectMake(10, 33, 290, 20);
	UILabel *lblTemp;
	
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CellFrame reuseIdentifier:cellIdentifier];
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier ];
	
	//Initialize Label with tag 1.
	lblTemp = [[UILabel alloc] initWithFrame:Label1Frame];
	lblTemp.tag = 1;
	[cell.contentView addSubview:lblTemp];
    lblTemp.backgroundColor = [UIColor clearColor];

	//Initialize Label with tag 2.
	lblTemp = [[UILabel alloc] initWithFrame:Label2Frame];
	lblTemp.tag = 2;
	lblTemp.font = [UIFont boldSystemFontOfSize:12];
	lblTemp.textColor = [UIColor grayColor];
	[cell.contentView addSubview:lblTemp];
	
    lblTemp.backgroundColor = [UIColor clearColor];
    
	return cell;
}


- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
//    NSLog(@"****************** entering commitEditingStyle:forRowAtIndexPath");

    [FlurryAnalytics logEvent:@"ENTERING COMMIT EDITING"];

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
  //      NSLog(@"listOfItems is %@", listOfItems);
        NSLog(@"accessnumbers is %@", accessNumbers);

        
         //REMOVING OBJECT FROM SECTION   
         NSMutableArray *section = [listOfItems objectAtIndex:indexPath.section];    
        NSLog(@"section is %@", section);

        [section removeObjectAtIndex:indexPath.row];
        [tblSimpleTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];

        NSLog(@"section is %@", section);

        //UPDATING/SAVING USERS DEFAULTS
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];            
//        [defaults setObject:section forKey:@"listOfAccessNumbers"];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:accessNumbers];
        [defaults setObject:data forKey:@"listOfAccessNumbers"];    


//        NSLog(@"listOfItems is %@", listOfItems);
//        NSLog(@"accessnumbers is %@", accessNumbers);

        
        //REMOVE LAST ROW FROM TABLE VIEW
        if ([section count] == 0) {
            
            lastIndexPath = nil;
            //self.navigationItem.rightBarButtonItem = nil;
            //        self.navigationItem.rightBarButtonItem.enabled = NO;  
            sectionIndicator = NO;
            [listOfItems removeObject:accessNumbers];    
            tblSimpleTable.editing = NO;
//            self.navigationItem.rightBarButtonItem = nil;
  //          [tblSimpleTable reloadData];
            [self setEditing:NO animated:YES];
            
            [self.navigationItem setRightBarButtonItem:nil animated:YES];
            
            accessNumberChecked = NO;

            //SAVE DATA IN NSUSERDEFAULTS
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
            [defaults setBool:accessNumberChecked  forKey:@"accessNumberChecked"];  
            
        }
        else
        {
            NSLog(@"ALERT ALERT!!!!");
            NSLog(@"sectionIndicator is %d", sectionIndicator);

           // sectionIndicator = YES;
        }
    }  
    
    //Inserting an element to the table 
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        NSMutableArray * section = [listOfItems objectAtIndex:indexPath.section];    
//        [section addObject:@"mac mini"];
//        [tblSimpleTable insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
// 		[tblSimpleTable reloadData];
    }
    
    [tblSimpleTable reloadData];

}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [FlurryAnalytics logEvent:@"ROW SELECTED IN SECTION 0"];

    //NSLog(@"****************** entering willSelectRowAtIndexPath");
    
    int newRow = [indexPath row];
    int oldRow = [lastIndexPath row];

        NSLog(@" newRow is: %d", newRow);
        NSLog(@" oldRow is: %d", oldRow);
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section == 0) 
    {
        //Checking an access number for the first time 
        if (selectedCell.accessoryType == UITableViewCellAccessoryNone && accessNumberChecked == NO)
        {
            selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
            accessNumberChecked = YES;
            NSArray *array = [[NSArray alloc] init];
            array = [listOfItems objectAtIndex:indexPath.section];
            
            NSLog(@" array is: %@", array);

            
            NSString *cellValue = [array objectAtIndex:indexPath.row];
            selectedAccessNumber = cellValue;
            accessObj = (NumberDataObj *)cellValue;
            lastIndexPath = indexPath;
            
            NSLog(@" accessObj.inputNum is: %@", accessObj.inputNum);
            NSLog(@" accessObj.inputName is: %@", accessObj.inputName);
            
            //SAVE DATA IN NSUSERDEFAULTS
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:indexPath];
            NSNumber *number = [NSNumber numberWithInt:indexPath.row];
            [defaults setObject:data forKey:@"lastIndexPath"];    
            [defaults setObject:number  forKey:@"lastIndexPathRow"];  
            [defaults setBool:accessNumberChecked  forKey:@"accessNumberChecked"];  
        }
        //Switching a checked cell 
        else  if (accessNumberChecked == YES && (newRow != oldRow))     
        {
            selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
            UITableViewCell *oldCell = [tableView cellForRowAtIndexPath: lastIndexPath];
            oldCell.accessoryType = UITableViewCellAccessoryNone;

            NSArray *array = [[NSArray alloc] init];
            array = [listOfItems objectAtIndex:indexPath.section];
            NSString *cellValue = [array objectAtIndex:indexPath.row];
            selectedAccessNumber = cellValue;
            accessObj = (NumberDataObj *)cellValue;

            lastIndexPath = indexPath;
            
            //SAVE DATA IN NSUSERDEFAULTS
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:indexPath];
            NSNumber *number = [NSNumber numberWithInt:indexPath.row];
            [defaults setObject:data forKey:@"lastIndexPath"];    
            [defaults setObject:number  forKey:@"lastIndexPathRow"];    
            [defaults setBool:accessNumberChecked  forKey:@"accessNumberChecked"];  
            
            NSLog(@" indexPath is: %@", indexPath);
            NSLog(@" number is: %@", number);

            NSNumber *temp = [defaults objectForKey:@"lastIndexPathRow"];
            NSLog(@"number  %@", temp );

        }
        //Unchecking a checked cell
        else if (selectedCell.accessoryType == UITableViewCellAccessoryCheckmark && (newRow == oldRow))
        {
            selectedCell.accessoryType = UITableViewCellAccessoryNone;
            accessNumberChecked = NO;
            lastIndexPath = nil;
//            accessObj.inputNum = @"";
            accessObj = nil;

            //SAVE DATA IN NSUSERDEFAULTS
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:indexPath];
            NSNumber *number = [NSNumber numberWithInt:indexPath.row];
            [defaults setObject:data forKey:@"lastIndexPath"];  
            [defaults setObject:number  forKey:@"lastIndexPathRow"];    
            [defaults setBool:accessNumberChecked  forKey:@"accessNumberChecked"];  

        }
    }
    
    return indexPath;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
 // NSLog(@"****************** entering tableView:didSelectRowAtIndexPath");
       
    //Delesect selected cell 
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ( sectionIndicator == YES) {
        if (indexPath.section == 1) {
            [self addAccessNumber:nil];
        }     
        else if (indexPath.section == 2) {
            [self launchAB:nil];
        }     
    }
    else
    {
        if (indexPath.section == 0) {
            [self addAccessNumber:nil];
        }     
        else if (indexPath.section == 1) {
            [self launchAB:nil];
        }      
    }
}


//-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section == 2) {
//        return 120.0;
//    }     
//    else
//    return 20.0;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if ( sectionIndicator == YES) {
        if (indexPath.section == 0) {        
            return 60;
        }   
        else if (indexPath.section == 1) {
            return 44;
        }     
        else
            return 44;
    }
    else
    {
        if (indexPath.section == 0) {        
            return 44;
        }     
        else
            return 44;
    }

	return 60;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    if ( sectionIndicator == YES) {
        if (section == 0) {        
            return 20;
        }   
        else if (section == 1) {
            return 30;
        }     
        else
            return 80;
    }
    else
    {
        if (section == 0) {        
            return 30;
        }     
        else
            return 80;
    }
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

   // NSLog(@"****************** entering tableView:canEditRowAtIndexPath");
    
    // Replace 0 with whichever section you want editable
    if (indexPath.section == 0 && sectionIndicator == YES) {
        return YES;
    } else {
        return NO;
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
  //  NSLog(@"****************** entering setEditing:animated");
    
    NSLog(@"editing is: %d, and animated is %d", editing, animated);
    
    [super setEditing:editing animated:animated];
    [tblSimpleTable setEditing:editing animated:animated];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
  //  NSLog(@"****************** entering tableView:titleForHeaderInSection");

        if(section == 0) 
            return NSLocalizedString(@"SelectAccessNumber", nil);
        else if (section == 2 && sectionIndicator == YES)
            return NSLocalizedString(@"SelectPasscode", nil);
        else if (section == 1 && sectionIndicator == NO)
            return NSLocalizedString(@"SelectPasscode", nil);
        else    
            return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [listOfItems count];    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[listOfItems objectAtIndex:section] count];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
   //     NSLog(@"****************** entering tableView:didEndEditingRowAtIndexPath");
        [tblSimpleTable reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return NSLocalizedString(@"Delete", nil);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ;
}


@end
