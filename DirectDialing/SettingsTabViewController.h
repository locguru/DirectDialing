//
//  SettingsTabViewController.h
//  DirectDialing
//
//  Created by Itai Ram on 12/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "AccessNumber.h"

@protocol SettingsTabViewControllerDelegate 
@required
- (void) refreshTableView:(NSString *) trasnferedNumber: (NSString *) transferedNumberName;
@end


@interface SettingsTabViewController : UIViewController <UITextFieldDelegate, ABPeoplePickerNavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, SettingsTabViewControllerDelegate> {
    
    UITextField *textField;
    UITextField *nameTextField;

    IBOutlet UILabel *firstName;
    IBOutlet UILabel *lastName;
    NSString *number;
    NSString *accessNumberName;
    
     id <SettingsTabViewControllerDelegate> delegate;
    
    IBOutlet UITableView *tblSimpleTable;
    NSMutableArray *listOfItems;

}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) UITextField *nameTextField;
@property (nonatomic, retain) UILabel *firstName;
@property (nonatomic, retain) UILabel *lastName;
@property (nonatomic, retain) NSString *number;
@property (nonatomic, retain) NSString *accessNumberName;

@property (nonatomic, retain) IBOutlet UITableView *tblSimpleTable;
@property (nonatomic, retain) NSMutableArray *listOfItems;

- (IBAction)importContactFromAddressBook:(id)sender;
- (IBAction)cancelView:(id)sender;
- (IBAction)continueView:(id)sender;
- (IBAction)dismissKeyboard:(UITextField *)textField1;
- (IBAction)dismissScreen:(id)sender;

@end
