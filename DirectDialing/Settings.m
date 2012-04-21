//
//  Settings.m
//  DirectDialing
//
//  Created by Itai Ram on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"
#import <Twitter/Twitter.h>

static NSString* kAppId = @"349376771765571";

@interface Settings ()

@end

@implementation Settings

@synthesize listOfItems;
@synthesize tblSimpleTable;
@synthesize facebook;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Settings";
    self.view.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"smartphonebackground.png"]];

    //left BUTTON 
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(dismissVC:)];      
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
    NSMutableArray *addNewAccessNumberLabel = [NSMutableArray arrayWithObjects:@"Share on Facebook", @"Post to Twitter", nil];
    NSMutableArray *launchABArray = [NSMutableArray arrayWithObjects:@"Send us feedback", nil];

 //   [listOfItems addObject:enableIntNumbers];
    [listOfItems addObject:addNewAccessNumberLabel];
    [listOfItems addObject:launchABArray];

    //FACEBOOK INIT
    facebook = [[Facebook alloc] initWithAppId:@"349376771765571" andDelegate:self];
}

- (IBAction)dismissVC:(id)sender 
{
//    [FlurryAnalytics logEvent:@"CLICK ON 'CONTINUE' - LEAVING SECOND SCREEN"];
//    NSLog(@"entering continueView disimssing manual number ");
    [self dismissModalViewControllerAnimated:YES];
}

//FACEBOOK API
- (void)fbDidLogin {

    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    //    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    //    [defaults synchronize];
    
    NSLog(@"entering fbDidLogin");
    
    NSString *link = @"http://itunes.apple.com/us/app/smart-phone/id511179270?ls=1&mt=8";
    NSString *linkName = @"Smart Phone app By Delengo";
    NSString *linkCaption = @"Check it out on the App Store!";
    NSString *linkDescription = @"";
    NSString *message = @"Love using Smart Phone app for the iPhone by Delengo";
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   kAppId, @"api_key",
                                   message, @"message",
                                   linkName, @"name",
                                   linkDescription, @"description",
                                   link, @"link",
                                   linkCaption, @"caption",
                                   nil];
    
    [facebook requestWithGraphPath: @"me/feed" andParams: params andHttpMethod: @"POST" andDelegate: self];
    
}

-(void)fbDidNotLogin:(BOOL)cancelled {
	NSLog(@"did not login");
}

- (void)request:(FBRequest *)request didLoad:(id)result {
	
    if ([result isKindOfClass:[NSArray class]]) {
		result = [result objectAtIndex:0];
	}
	
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Smart Phone" 
                                                    message:@"You successfully shared Smart Phone app on your Facebook wall!" 
                                                   delegate:nil 
                                          cancelButtonTitle:@"Dismiss"
                                          otherButtonTitles:nil];
    [alert show];
    
    NSLog(@"Result of API call: %@", result);
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error{
    
    NSLog(@"didFailWithError: %@", [error description]);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Share on Facebook" 
                                                    message:@"An error occured" 
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Sending Failed - Unknown Error :-("
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
            
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //  NSLog(@"****************** entering cellForRowAtIndexPath at Section %d", indexPath.section);
    
    // static NSString *CellIdentifier = @"Cell";
    
    static NSString *CellIdentifier1 = @"Cell_Section_1";
    UITableViewCell *cell;
      
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1]; 
        NSArray *array = [[NSArray alloc] init];
        array = [listOfItems objectAtIndex:indexPath.section];
        cell.textLabel.text = [array objectAtIndex:indexPath.row];

//    if(indexPath.section == 0)
//    {
//        UISwitch *switch1 = [[UISwitch alloc] initWithFrame:CGRectZero];
//        [cell addSubview:switch1];
//        cell.accessoryView = switch1;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // NSLog(@"****************** entering tableView:didSelectRowAtIndexPath");
    
   // NSLog(@"touched row %d", indexPath.row);
    
    [tblSimpleTable deselectRowAtIndexPath:indexPath animated:YES];

    
//    if(indexPath.section == 0) 
    if(0)
    {
        //NSLog(@"touched row %d", indexPath.row);
    }
    else if (indexPath.section == 0)
    {
        //NSLog(@"touched row %d", indexPath.row);
        
        if (indexPath.row == 0)
        {
            [FlurryAnalytics logEvent:@"POSTING ON FACEBOOK"];
            NSLog(@"entering POSTING ON FACEBOOK");
            [facebook authorize:[NSArray arrayWithObjects:@"publish_stream", nil]];
        }
        else if (indexPath.row == 1)
        {
            [FlurryAnalytics logEvent:@"CLICK ON SHARE ON TWITTER"];

            NSString* versionNumber = [[UIDevice currentDevice] systemVersion];
            int version;
            version = [versionNumber intValue];
            NSLog(@"versionNumber %d", version);
            
            if (version < 5)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Smart Phone" message:@"Youd OS version doesn't support Twitter on this app. Please upgrade your OS an try again" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
                [alert show];
            }
            else    
            {
                TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
                [twitter setInitialText:@"Enjoying using @Delengo recent app - Smart Phone, what a great application! #iphone #appstore #business"];
                [self presentModalViewController:twitter animated:YES];
                
                // Called when the tweet dialog has been closed
                twitter.completionHandler = ^(TWTweetComposeViewControllerResult result) 
                {
                    NSString *title = @"Smart Phone";
                    NSString *msg; 
                    
                    if (result == TWTweetComposeViewControllerResultCancelled)
                        msg = @"Tweet compostion was canceled";
                    else if (result == TWTweetComposeViewControllerResultDone)
                        msg = @"Your tweet has been posted!";
                    
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alertView show];
                    
                    [self dismissModalViewControllerAnimated:YES];
                };
            }

        }
    }
    else if (indexPath.section == 1)
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

//-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
//{
//        if (section == 0) {        
//            return 60;
//        }   
//        else if (section == 1) {
//            return 20;
//        }     
//        else
//            return 30;
//
//}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
{    
    if(0) 
        return @"Support International Numbers";
    else if (section == 0)
        return @"Sharing Options";
    else if (section == 1)
        return @"Contact Us";
    else    
        return nil;
}

//- (NSString *)tableView:(UITableView *)tv titleForFooterInSection:(NSInteger)section
//{
//    if (section == 0)
//        return NSLocalizedString(@"NumberInstructions", nil);
//    else 
//        return nil;
//}

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
