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
#import "NumberDataObj.h"
//#import "History.h"


//@protocol AddItemHistoryDelegate 
//@required
////- (void) addNewItem:(NSString *)newProduct withNewBrand:(NSString *)newBrand;
//- (void) processSuccessful;
//@end


@interface AccessNumber : UIViewController <UITableViewDelegate, UITableViewDataSource, ABPeoplePickerNavigationControllerDelegate, UIAlertViewDelegate, UIActionSheetDelegate> {
    
    NSString *selectedAccessNumber;
    NSString *directNumber;
    UIButton *manualDial;
    UIButton *selectNumber;
    IBOutlet UITableView *tblSimpleTable;
    NSMutableArray *listOfItems;
    BOOL accessNumberChecked;
    BOOL sectionIndicator;
    BOOL dialAlertSwitch;
    
    NSMutableArray *accessNumbers;
    NumberDataObj *numDataObj;
    
    UIScrollView *mainScrollView;
    NSString *firstName;
    NSString *lastName;
    NSString *phoneNumber;
    NSString *fullNumber;
    NumberDataObj *accessObj;
    
    NSIndexPath *lastIndexPath;
    
    UILabel *cellLabel1;
    UILabel *cellLabel2;

    // id <AddItemHistoryDelegate> delegate;
    
}
//@property (nonatomic, retain) id delegate;

@property (nonatomic, retain) NSString *selectedAccessNumber;
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
@property (nonatomic, retain) NumberDataObj *accessObj;
@property (nonatomic, retain) UIScrollView *mainScrollView;
@property (nonatomic, retain) NSIndexPath *lastIndexPath;
@property (nonatomic, retain) UILabel *cellLabel1;
@property (nonatomic, retain) UILabel *cellLabel2;
@property (nonatomic, retain) NumberDataObj *numDataObj;

- (IBAction)dialNumber:(NSString *)phoneNum;
- (IBAction)launchDialer:(id)sender;
- (IBAction)addAccessNumber:(id)sender;
- (IBAction)launchAB:(id)sender;
- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier;

-(IBAction) postMessage:(id) sender;


@end
