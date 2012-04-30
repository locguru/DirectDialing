//
//  Settings.h
//  DirectDialing
//
//  Created by Itai Ram on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "FlurryAnalytics.h"
#import "AccessNumber.h"


@interface Settings : UIViewController <UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate> {
    
    IBOutlet UITableView *tblSimpleTable;
    NSMutableArray *listOfItems;
    UISwitch *switch1;

}

@property (nonatomic, retain) IBOutlet UITableView *tblSimpleTable;
@property (nonatomic, retain) NSMutableArray *listOfItems;
@property (nonatomic, retain) UISwitch *switch1;

- (IBAction)switchAction:(id)sender;

@end
