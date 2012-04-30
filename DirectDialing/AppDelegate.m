//
//  AppDelegate.m
//  DirectDialing
//
//  Created by Itai Ram on 12/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "FlurryAnalytics.h"
#import "AccessNumber.h"

static NSString* kAppId = @"349376771765571";

@implementation AppDelegate

@synthesize window = _window;
@synthesize accessNumber = _accessNumber;
@synthesize facebook;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //FLURRY SUPPORT 
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    [FlurryAnalytics startSession:@"TQUTDLIUNA8LEXWIQMJN"];
        
    //FACEBOOK
    facebook = [[Facebook alloc] initWithAppId:@"349376771765571" andDelegate:self];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
 //   AccessNumber *viewController1 = [[AccessNumber alloc] initWithNibName:@"AccessNumber" bundle:nil];    
    _accessNumber = [[AccessNumber alloc] initWithNibName:@"AccessNumber" bundle:nil];    
    UINavigationController *navCntrl1 = [[UINavigationController alloc] initWithRootViewController:_accessNumber];
    self.window.rootViewController = navCntrl1;
    [self.window makeKeyAndVisible];
    return YES;
}

//FLURRY METHOD
void uncaughtExceptionHandler(NSException *exception) {

    NSArray *backtrace = [exception callStackSymbols];
    NSString *version = [[UIDevice currentDevice] systemVersion];
    NSString *message = [NSString stringWithFormat:@"CRASH! OS: %@. Backtrace:\n%@",version, backtrace];

    [FlurryAnalytics logError:@"Uncaught" message:message exception:exception];
}

//FACEBOOK API
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self.facebook handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self.facebook handleOpenURL:url]; 
}

- (void)fbDidLogin {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    NSLog(@"entering fbDidLogin");
    [FlurryAnalytics logEvent:@"ENTERING fbDidLogin - POST SUCCESSFULLY"];
    
 //   NSString *link = @"http://itunes.apple.com/us/app/smart-phone/id511179270?ls=1&mt=8"; //itunes store
    NSString *link = @"http://itunes.apple.com/us/app/smart-phone/id511179270?mt=8";
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
    
    [facebook requestWithGraphPath:@"me/feed" andParams: params andHttpMethod:@"POST" andDelegate:self];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Smart Phone" 
                                                    message:NSLocalizedString(@"SuccessfullySharedFacebook", nil) 
                                                   delegate:nil 
                                          cancelButtonTitle:NSLocalizedString(@"Dismiss", nil)
                                          otherButtonTitles:nil];
    [alert show];
    
}

-(void)fbDidNotLogin:(BOOL)cancelled {
	NSLog(@"did not login");
}

- (void)requestLoading:(FBRequest *)request{
    NSLog(@"enter requestLoading");
}

- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"enter didReceiveResponse");
}

- (void)request:(FBRequest *)request didLoadRawResponse:(NSData *)data {
    NSLog(@"enter didLoadRawResponse");
}

- (void)request:(FBRequest *)request didLoad:(id)result {
	
    if ([result isKindOfClass:[NSArray class]]) {
		result = [result objectAtIndex:0];
	}    
    NSLog(@"Result of API call: %@", result);
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error{
    
    NSLog(@"didFailWithError: %@", [error description]);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ShareFacebook", nil) 
                                                    message:NSLocalizedString(@"AnErrorOccured", nil) 
                                                   delegate:nil 
                                          cancelButtonTitle:NSLocalizedString(@"Dismiss", nil)
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
