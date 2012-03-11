//
//  AccessNumber.h
//  DirectDialing
//
//  Created by Itai Ram on 12/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

//#import "SettingsTabViewController.h"


@interface AccessNumber : UIViewController <UITableViewDelegate, UITableViewDataSource, ABPeoplePickerNavigationControllerDelegate, UIAlertViewDelegate> {
    
    NSString *selectedAccessNumber;
//    NSString *newAccessNumber;
    NSString *directNumber;
    UIButton *manualDial;
    UIButton *selectNumber;
    IBOutlet UITableView *tblSimpleTable;
    NSMutableArray *listOfItems;
    BOOL accessNumberChecked;
    BOOL sectionIndicator;
    NSMutableArray *accessNumbers;
    
    UIScrollView *mainScrollView;
    NSString *firstName;
    NSString *lastName;
    NSString *phoneNumber;
    NSString *fullNumber;
    NSString *accessNumber;
    
    NSIndexPath *lastIndexPath;
    NSIndexPath *selectedIndexPath;
    
    UILabel *cellLabel1;
    UILabel *cellLabel2;

}

@property (nonatomic, retain) NSString *selectedAccessNumber;
//@property (nonatomic, retain) NSString *newAccessNumber;
@property (nonatomic, retain) NSString *directNumber;
@property (nonatomic, retain) IBOutlet UIButton *manualDial;
@property (nonatomic, retain) IBOutlet UIButton *selectNumber;
@property (nonatomic, retain) IBOutlet UITableView *tblSimpleTable;
@property (nonatomic, retain) NSMutableArray *listOfItems;
@property (nonatomic, retain) NSMutableArray *accessNumbers;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *phoneNumber;
@property (nonatomic, retain) NSString *fullNumber;
@property (nonatomic, retain) NSString *accessNumber;
@property (nonatomic, retain) UIScrollView *mainScrollView;
@property (nonatomic, retain) NSIndexPath *lastIndexPath;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
@property (nonatomic, retain) UILabel *cellLabel1;
@property (nonatomic, retain) UILabel *cellLabel2;

- (IBAction)dialNumber:(NSString *)phoneNum;
- (IBAction)launchDialer:(id)sender;
- (IBAction)addAccessNumber:(id)sender;
- (IBAction)launchAB:(id)sender;
- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier;

@end
