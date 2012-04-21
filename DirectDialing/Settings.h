//
//  Settings.h
//  DirectDialing
//
//  Created by Itai Ram on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"
#import <MessageUI/MessageUI.h>
#import "FlurryAnalytics.h"

@interface Settings : UIViewController <UITableViewDelegate, UITableViewDataSource, FBSessionDelegate, FBRequestDelegate, MFMailComposeViewControllerDelegate> {
    
    IBOutlet UITableView *tblSimpleTable;
    NSMutableArray *listOfItems;

   	//Facebook 
    Facebook *facebook;

}

@property (nonatomic, retain) IBOutlet UITableView *tblSimpleTable;
@property (nonatomic, retain) NSMutableArray *listOfItems;

@property (nonatomic, retain) Facebook *facebook;

@end
