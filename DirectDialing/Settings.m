//
//  Settings.m
//  DirectDialing
//
//  Created by Itai Ram on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"
#import <Twitter/Twitter.h>
#import "AppDelegate.h"

@interface Settings ()

@end

@implementation Settings

@synthesize listOfItems;
@synthesize tblSimpleTable;
@synthesize switch1;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        switch1 = [[UISwitch alloc] initWithFrame:CGRectZero];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = NSLocalizedString(@"Settings", nil);
    self.view.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"smartphonebackground.png"]];

    //left BUTTON 
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil) style:UIBarButtonItemStylePlain target:self action:@selector(dismissVC:)];      
    self.navigationItem.leftBarButtonItem = leftButton;

    //CREATING UITABLEVIEW 
    tblSimpleTable = [[UITableView alloc]  initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped ];
    tblSimpleTable.scrollEnabled = YES;
    tblSimpleTable.backgroundColor = [UIColor clearColor];
    tblSimpleTable.dataSource = self;
    tblSimpleTable.bounces = NO;
    tblSimpleTable.delegate = self;
    [self.view addSubview:tblSimpleTable];
    
    //INITIALIZING DATA SOURCE
    listOfItems = [[NSMutableArray alloc] init];
    NSMutableArray *enableIntNumbers = [NSMutableArray arrayWithObjects:@"Enable", nil];
    NSMutableArray *disableConfirmationAlert = [NSMutableArray arrayWithObjects:NSLocalizedString(@"DialConfirmationAlert", nil), nil];
    NSMutableArray *addNewAccessNumberLabel = [NSMutableArray arrayWithObjects:NSLocalizedString(@"ShareFacebook", nil), NSLocalizedString(@"PostTwitter", nil), nil];
    NSMutableArray *launchABArray = [NSMutableArray arrayWithObjects:NSLocalizedString(@"SendFeedback", nil), nil];

 //   [listOfItems addObject:enableIntNumbers];
    [listOfItems addObject:disableConfirmationAlert];
    [listOfItems addObject:addNewAccessNumberLabel];
    [listOfItems addObject:launchABArray];

}

- (IBAction)dismissVC:(id)sender 
{
    [FlurryAnalytics logEvent:@"CLICK ON 'CONTINUE' - LEAVING SECOND SCREEN"];
    //NSLog(@"entering continueView disimssing manual number ");
    [self dismissModalViewControllerAnimated:YES];
}

//MAIL DELEGATE METHODS
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{ 
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            break;
        case MFMailComposeResultFailed:
            break;
            
        default:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Email", nil) message:NSLocalizedString(@"SendingFailed", nil)
                                                           delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles: nil];
            [alert show];
        }
            
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //  NSLog(@"****************** entering cellForRowAtIndexPath at Section %d", indexPath.section);
        
    static NSString *CellIdentifier1 = @"Cell_Section_1";
    UITableViewCell *cell;
      
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1]; 
        NSArray *array = [[NSArray alloc] init];
        array = [listOfItems objectAtIndex:indexPath.section];
        cell.textLabel.text = [array objectAtIndex:indexPath.row];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;

    if(indexPath.section == 0)
    {
        //UISwitch *switch1 = [[UISwitch alloc] initWithFrame:CGRectZero];
        [cell addSubview:switch1];
        cell.accessoryView = switch1;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];     
        BOOL tempBool;
        //NSLog(@"tempBool %d", tempBool);

        tempBool = [defaults boolForKey:@"DialNotificationAlertState"];
        [switch1 setOn:tempBool animated:YES];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [switch1 addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];

    }
    else if(indexPath.section == 1)
    {
       if(indexPath.row == 0)
           cell.imageView.image = [UIImage imageNamed:@"facebookicon.png"];
        else if(indexPath.row == 1)
            cell.imageView.image = [UIImage imageNamed:@"twittericon.png"];
        else 
            NSLog(@"Do Nothing");
    }


    return cell;
}

- (IBAction)switchAction:(id)sender {
    
    //SAVE SWITCH STATE IN NSUSERDEFAULTS
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 

    if (switch1.on == 0) { //Gets in when swtiche turns OFF
      //  NSLog(@"switch1.state row %d", switch1.on);
        [defaults setBool:NO forKey:@"DialNotificationAlertState"];
    }
    else { //Gets in when switch turns ON
      //  NSLog(@"switch1.state row %d", switch1.on);
        [defaults setBool:YES forKey:@"DialNotificationAlertState"];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [tblSimpleTable deselectRowAtIndexPath:indexPath animated:YES];

    if(indexPath.section == 0)
    {
        NSLog(@"touched row %d", indexPath.row);
    }
    //Facebook and Twitter Section
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) //Facebook
        {
            [FlurryAnalytics logEvent:@"POSTING ON FACEBOOK"];
         //   NSLog(@"entering POSTING ON FACEBOOK");
            
            AppDelegate *appDelegateObj = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegateObj.facebook authorize:[NSArray arrayWithObjects:@"publish_stream", nil]]; 

            return;
        }
        else if (indexPath.row == 1) //Twitter 
        {
            [FlurryAnalytics logEvent:@"CLICK ON SHARE ON TWITTER"];

            NSString* versionNumber = [[UIDevice currentDevice] systemVersion];
            int version;
            version = [versionNumber intValue];
            NSLog(@"versionNumber %d", version);
            
            if (version < 5)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Smart Phone" message:NSLocalizedString(@"TwitterOSVersion", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Dismiss", nil) otherButtonTitles: nil];
                [alert show];
            }
            else    
            {
                TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
                [twitter setInitialText:@"Enjoying using @Delengo recent app - Smart Phone, check it out! http://itunes.apple.com/us/app/smart-phone/id511179270?ls=1&mt=8 #iphone #appstore #business"];
                [self presentModalViewController:twitter animated:YES];
                
                // Called when the tweet dialog has been closed
                twitter.completionHandler = ^(TWTweetComposeViewControllerResult result) 
                {
                    NSString *title = @"Smart Phone";
                    NSString *msg; 
                                        
                    if (result == TWTweetComposeViewControllerResultCancelled)
                        msg = NSLocalizedString(@"TweetCancelled", nil);
                    else if (result == TWTweetComposeViewControllerResultDone)
                        msg = NSLocalizedString(@"TweetPosted", nil);
                    
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles:nil];
                    [alertView show];
                    
                    [self dismissModalViewControllerAnimated:YES];
                };
            }

        }
    }
    //Contact us section
    else if (indexPath.section == 2)
    {
        [FlurryAnalytics logEvent:@"CLICK ON CONTACT US"];
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        [controller setToRecipients:[NSArray arrayWithObject:@"support@delengo.com"]];
        [controller setSubject:@"Inquiry Re: Smart Phone app"];
        [controller setMessageBody:nil isHTML:NO]; 
        if (controller) [self presentModalViewController:controller animated:YES];
    }
    else
    {
       // NSLog(@"touched row %d", indexPath.row); 
    }
 
 }

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
        if (section == 0) {        
            return 40;
        }   
        else if (section == 1) {
            return 20;
        }     
        else
            return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
{    
    if(0) 
        return @"Support International Numbers";
    else if (section == 0)
        return NSLocalizedString(@"NotificationSettings", nil);
    else if (section == 1)
        return NSLocalizedString(@"SharingOptions", nil);
    else if (section == 2)
        return NSLocalizedString(@"ContactUs", nil);
    else    
        return nil;
}

- (NSString *)tableView:(UITableView *)tv titleForFooterInSection:(NSInteger)section
{
    if (section == 0)
//        return NSLocalizedString(@"NumberInstructions", nil);
        return NSLocalizedString(@"DialConfirmationAlertFooter", nil);

    else 
        return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [listOfItems count];    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[listOfItems objectAtIndex:section] count];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ;
}



@end
