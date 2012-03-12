//
//  AccessNumber.m
//  DirectDialing
//
//  Created by Itai Ram on 12/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AccessNumber.h"
#import "ViewController.h"
#import "AddNewAccessNumber.h"
#import "SettingsTabViewController.h"
#import "NumberDataObj.h"

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
@synthesize accessNumber;
@synthesize lastIndexPath;
@synthesize selectedIndexPath;

@synthesize cellLabel1;
@synthesize cellLabel2;

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
        accessNumber = [[NSString alloc] initWithString:@""];
        cellLabel1 = [[UILabel alloc] init];
        cellLabel2 = [[UILabel alloc] init];
        numDataObj = [[NumberDataObj alloc] init];
    }
    return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    accessNumberChecked = NO; 
    cellLabel1.text = @"Access Number Name";
    cellLabel2.text = @"Access Number";
    
//    //ADDING BACKGROUND IMAGE 
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
//    imgView.image = [UIImage imageNamed:@"newbackground.png"];
//    [self.view addSubview: imgView];
//    [self.view sendSubviewToBack:imgView];

//    //ADDING SCROLL VIEW
//    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];   
//    [self.view addSubview:mainScrollView];    
//    CGSize scrollViewContentSize = CGSizeMake(280, 380);
//    [mainScrollView setContentSize:scrollViewContentSize];
//    //scrollview.bounces = NO;

    
    //TITLE AND NAV BAR ITEMS
    self.title = @"Direct Dialing";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = nil;

    //STEP 1 LABEL
//    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 280, 20)];
////	myLabel.text = NSLocalizedString(@"Step 1: Select Your Access Number", @"localized step 1");
//    myLabel.text = NSLocalizedString(@"TITLE", nil);
//	myLabel.backgroundColor = [UIColor clearColor]; // [UIColor brownColor];
//    myLabel.font = [UIFont boldSystemFontOfSize:16];
//    myLabel.textColor =  [UIColor colorWithRed:0.265 green:0.294 blue:0.367 alpha:1.0];
//    myLabel.shadowColor = [UIColor colorWithWhite:1.0 alpha:1.0];
//    myLabel.shadowOffset = CGSizeMake(0, 1);
//	[self.view addSubview:myLabel];

//    //STEP 2 LABEL
//    UILabel *myLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 240, 280, 40)];
//	myLabel1.text = @"2. Select the direct/ID number";
//	myLabel1.backgroundColor = [UIColor clearColor]; // [UIColor brownColor];
//    myLabel1.font = [UIFont boldSystemFontOfSize:16];;
//    myLabel1.textColor =  [UIColor colorWithRed:0.265 green:0.294 blue:0.367 alpha:1.0];
//    myLabel1.shadowColor = [UIColor colorWithWhite:1.0 alpha:1.0];
//    myLabel1.shadowOffset = CGSizeMake(0, 1);
//	//[self.view addSubview:myLabel1];
//	[mainView addSubview:myLabel1];
    
    //CREATING THE TABLE 
    tblSimpleTable = [[UITableView alloc]  initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped ];
 //   tblSimpleTable = [[UITableView alloc] init];
//    tblSimpleTable.backgroundColor = [UIColor clearColor];
     tblSimpleTable.scrollEnabled = YES;
//   tblSimpleTable.bounces = YES;
    tblSimpleTable.dataSource = self;
    tblSimpleTable.delegate = self;
    [self.view addSubview:tblSimpleTable];
 //   [mainView addSubview:tblSimpleTable];

    //TABLE DATA
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];     
    accessNumbers = [defaults objectForKey:@"listOfAccessNumbers"];
    //NSLog(@"accessNumbers  %@", accessNumbers);
//    NSLog(@"accessNumbers size %d", [accessNumbers count]);

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
    
    listOfItems = [[NSMutableArray alloc] init];
    NSMutableArray *addNewAccessNumberLabel = [NSMutableArray arrayWithObjects:@"Add new access number", nil];
    NSMutableArray *launchABArray = [NSMutableArray arrayWithObjects:@"                         Address Book", nil];

    
    if ( sectionIndicator == YES) {
        [listOfItems addObject:accessNumbers];
    }
    
    [listOfItems addObject:addNewAccessNumberLabel];
    [listOfItems addObject:launchABArray];

    selectedIndexPath = nil;
}


- (IBAction)addAccessNumber:(id)sender {  
    
    SettingsTabViewController *addNewAccessNumberVC = [[SettingsTabViewController alloc] initWithNibName:nil bundle:nil];
    addNewAccessNumberVC.delegate = self;
    UINavigationController *addNewAccessNumberVCNav = [[UINavigationController alloc] initWithRootViewController:addNewAccessNumberVC];
    addNewAccessNumberVCNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;    
    [self presentModalViewController:addNewAccessNumberVCNav animated:YES];

}

- (IBAction)launchDialer:(id)sender {  
    
    ViewController *dialerController = [[ViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *dialerControllerNav = [[UINavigationController alloc] initWithRootViewController:dialerController];
    dialerControllerNav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;    
    [self presentModalViewController:dialerControllerNav animated:YES];
}

- (IBAction)launchAB:(id)sender{
    
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    [self presentModalViewController:picker animated:YES];
}


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
    
    fullNumber = [NSString stringWithFormat:@"%@%@%@%@", @"tel:", accessNumber, @",", strippedString];
    NSString *myMessage = [NSString stringWithFormat:@"Please confirm dialing to:%@ with the access code:%@", phoneNumber , accessNumber];
    UIAlertView *alert;
    
    if([accessNumber length] == 0 | [phoneNumber length] == 0)
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Direct Dialing" 
                                                        message:@"Please enter an Access Number and try again"
                                                       delegate:self 
                                              cancelButtonTitle:@"Ok" 
                                              otherButtonTitles:nil, nil];
 
    }
    else
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Direct Dialing" 
                                       message:myMessage
                                      delegate:self 
                             cancelButtonTitle:@"Cancel" 
                             otherButtonTitles:@"Ok", nil];
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

    }
}

//***** CUSTOME TABLE METHOD *****//

- (void) refreshTableView:(NSString *) trasnferedNumber: (NSString *) transferedNumberName{
    
//    NSLog(@"entering refreshTableView");
//    NSLog(@"transferedNumberName %@", transferedNumberName);
//    NSLog(@"Process completed");
//    NSLog(@"listOfItems %@", listOfItems);    
//    NSLog(@"trasnferedNumber.length: %d", trasnferedNumber.length);

    numDataObj = [[NumberDataObj alloc] init];
    
    if (trasnferedNumber.length != 0) 
    {        
        if (trasnferedNumber.length < 9)
        {
            NSString *formattedString = trasnferedNumber;
            numDataObj.inputName = transferedNumberName;
            numDataObj.inputNum = formattedString;
            
         //   [accessNumbers addObject:formattedString];
            [accessNumbers addObject:numDataObj];
            
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

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];            
        [defaults setObject:accessNumbers forKey:@"listOfAccessNumbers"];
        
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
    
    NSLog(@"****************** entering cellForRowAtIndexPath at Section %d", indexPath.section);

   // static NSString *CellIdentifier = @"Cell";
    
    static NSString *CellIdentifier1 = @"Cell_Section_1";
	static NSString *CellIdentifier2 = @"Cell_Section_2";
    UITableViewCell *cell;
    
    
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
    //2 Section Case
    else
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1]; 
        NSArray *array = [[NSArray alloc] init];
        array = [listOfItems objectAtIndex:indexPath.section];
        cell.textLabel.text = [array objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithRed:.196 green:0.3098 blue:0.52 alpha:1.0];

    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        
////          if (indexPath.section == 0 && sectionIndicator == YES) {
//              cell = [self getCellContentView:CellIdentifier];
////          }
////          else {
////              cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier]; //try here diff styles
////          }
//
//    }
//    
//  //  NSLog(@"cell %@", cell);
//
//        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier]; //try here diff styles
//        //cell = [self getCellContentView:CellIdentifier];
////    
// //       NSLog(@"sectionIndicator: %d", sectionIndicator);
////        NSLog(@"indexPath.section %d", indexPath.section);
//        
//        //3 Section case
//    if ( sectionIndicator == YES ) 
//    {
//        
//        if (indexPath.section == 0) {      
//
////            NSArray *array = [[NSArray alloc] init];
////            array = [listOfItems objectAtIndex:indexPath.section];
////            cell.textLabel.text = [array objectAtIndex:indexPath.row];
////            cell.textLabel.font = [UIFont systemFontOfSize:14];
////            cell.textLabel.textColor = [UIColor colorWithRed:.196 green:0.3098 blue:0.52 alpha:1.0];
//            
//            
//           // cell = [self getCellContentView:CellIdentifier];
////            cellLabel1 = [[UILabel alloc] init];
////            cellLabel2 = [[UILabel alloc] init];
//
////            NSLog(@"cellLabel1.text %@", cellLabel1.text);
////            NSLog(@"cellLabel2.text %@", cellLabel2.text);
//            cellLabel1 = (UILabel *)[cell viewWithTag:1];
//            NSLog(@"cellLabel1 %@", cellLabel1);
//
//            cellLabel2 = (UILabel *)[cell viewWithTag:2];
//            cellLabel1.text = @"Sub Value1";
//            cellLabel2.text = @"Sub Value2";
//            NSLog(@"cellLabel1.text %@", cellLabel1.text);
//             NSLog(@"cellLabel2.text %@", cellLabel2.text);
//
////            NSArray *array = [[NSArray alloc] init];
////            array = [listOfItems objectAtIndex:indexPath.section];
////
////             NSLog(@"array array is: %@", array);
//////             NSLog(@"indexPath: %d", indexPath.row);
//////             NSLog(@"indexPath.section %d", indexPath.section);
////            
////            cellLabel1.text = @"Sub Value1";
////            cellLabel2.text = @"Sub Value2";
//////            cellLabel1.text = [array objectAtIndex:indexPath.row];
//////            cellLabel2.text = [array objectAtIndex:indexPath.row];
////
////         //   NSLog(@"cell %@", cell);
////            NSLog(@"[array objectAtIndex:indexPath.row] %@", [array objectAtIndex:indexPath.row]);
//            
//////            cellLabel1.textColor = [UIColor colorWithRed:.196 green:0.3098 blue:0.52 alpha:1.0];
//////            cellLabel2.textColor = [UIColor colorWithRed:.196 green:0.3098 blue:0.52 alpha:1.0];
////           
////            cellLabel1.backgroundColor = [UIColor clearColor];
////            cellLabel2.backgroundColor = [UIColor clearColor];
//
//        }   
//        else //sections 1 and 2
//        {    
//            //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier]; 
//            NSArray *array = [[NSArray alloc] init];
//            array = [listOfItems objectAtIndex:indexPath.section];
//            cell.textLabel.text = [array objectAtIndex:indexPath.row];
//            cell.textLabel.font = [UIFont systemFontOfSize:14];
//            cell.textLabel.textColor = [UIColor colorWithRed:.196 green:0.3098 blue:0.52 alpha:1.0];
//            
////            cellLabel1 = (UILabel *)[cell viewWithTag:1];            
////            cellLabel2 = (UILabel *)[cell viewWithTag:2];
////            cellLabel1.text = [array objectAtIndex:indexPath.row];
////            cellLabel2.text = [array objectAtIndex:indexPath.row];
//
//        }
//        
//    }
//        
//    //2 Section Case
//    else
//    {
//        NSArray *array = [[NSArray alloc] init];
//        array = [listOfItems objectAtIndex:indexPath.section];
////        cell.textLabel.text = [array objectAtIndex:indexPath.row];
////        cell.textLabel.font = [UIFont systemFontOfSize:14];
////        cell.textLabel.textColor = [UIColor colorWithRed:.196 green:0.3098 blue:0.52 alpha:1.0];
//
//        cellLabel1 = (UILabel *)[cell viewWithTag:1];            
//        cellLabel2 = (UILabel *)[cell viewWithTag:2];
//        cellLabel1.text = [array objectAtIndex:indexPath.row];
//        cellLabel2.text = [array objectAtIndex:indexPath.row];
//
//    }


    
    //Determine accessory indicators 
    if (sectionIndicator == YES){

        if (indexPath.section == 0) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else if (indexPath.section == 1) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    else
    {
        if (indexPath.section == 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        else
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    return cell;
}


- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier {
	
    NSLog(@"****************** entering getCellContentView");
    
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

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSLog(@"****************** entering willSelectRowAtIndexPath");

    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section == 0) 
    {
        //Checking an access number that was selected 
        if (selectedCell.accessoryType == UITableViewCellAccessoryNone && accessNumberChecked == NO)
        {
            selectedCell.accessoryType=UITableViewCellAccessoryCheckmark;
            accessNumberChecked = YES;
            NSArray *array = [[NSArray alloc] init];
            array = [listOfItems objectAtIndex:indexPath.section];
            NSString *cellValue = [array objectAtIndex:indexPath.row];
            selectedAccessNumber = cellValue;
            accessNumber = cellValue;
        }
        //Unchecking an access number 
        else  if (selectedCell.accessoryType == UITableViewCellAccessoryCheckmark)     
        {
            selectedCell.accessoryType=UITableViewCellAccessoryNone;
            accessNumberChecked = NO;
        }
    }
    
    return indexPath;
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
//    NSLog(@"****************** entering commitEditingStyle:forRowAtIndexPath");

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
         NSMutableArray * section = [listOfItems objectAtIndex:indexPath.section];    

        //UPDATING USERS DEFAULTS
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];            
        [section removeObjectAtIndex:indexPath.row];
        [defaults setObject:section forKey:@"listOfAccessNumbers"];
        [tblSimpleTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
		[tblSimpleTable reloadData];
     //   NSLog(@"section is %@", section);

        if ([section count] == 0) {
            //self.navigationItem.rightBarButtonItem = nil;
            //        self.navigationItem.rightBarButtonItem.enabled = NO;  
            sectionIndicator = NO;
            [listOfItems removeObject:accessNumbers];            
            [tblSimpleTable reloadData];
        }
        else
        {
            sectionIndicator = YES;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
 // NSLog(@"****************** entering tableView:didSelectRowAtIndexPath");
   
    //Selecting Checkmark based on selection
    if (indexPath.section == 0 && sectionIndicator == YES) {
          
        int newRow = [indexPath row];
        int oldRow = [lastIndexPath row];
        
        if (newRow != oldRow)
        {
            UITableViewCell *newCell = [tableView cellForRowAtIndexPath: indexPath];
            newCell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            UITableViewCell *oldCell = [tableView cellForRowAtIndexPath: lastIndexPath];
            oldCell.accessoryType = UITableViewCellAccessoryNone;
            
            lastIndexPath = indexPath;
        }
    }
    
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
    
    [super setEditing:editing animated:animated];
    [tblSimpleTable setEditing:editing animated:animated];
    
    
    //self.navigationItem.rightBarButtonItem = nil;
    
//    if (editing) {
//         editButton.enabled = NO;
//    } else {
//        editButton.enabled = YES;
//    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
  //  NSLog(@"****************** entering tableView:titleForHeaderInSection");
//    NSLog(@"section is %d", section);
//    NSLog(@"sectionIndicator %d", sectionIndicator);

        if(section == 0) 
            return @"1. Select your access number";
        else if (section == 2 && sectionIndicator == YES)
            return @"2. Select the direct/ID number";
        else if (section == 1 && sectionIndicator == NO)
            return @"2. Select the direct/ID number";
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
    return @"Delete";
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ;
}

@end
