//
//  AppDelegate.m
//  DirectDialing
//
//  Created by Itai Ram on 12/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
//#import "ViewController.h"
//#import "SettingsTabViewController.h"
#import "AccessNumber.h"
#import "FlurryAnalytics.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //FLURRY SUPPORT 
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    [FlurryAnalytics startSession:@"TQUTDLIUNA8LEXWIQMJN"];
        
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    AccessNumber *viewController1 = [[AccessNumber alloc] initWithNibName:@"AccessNumber" bundle:nil];    
    UINavigationController *navCntrl1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
    self.window.rootViewController = navCntrl1;
    [self.window makeKeyAndVisible];
    return YES;
}

void uncaughtExceptionHandler(NSException *exception) {

    NSArray *backtrace = [exception callStackSymbols];
    NSString *version = [[UIDevice currentDevice] systemVersion];
    NSString *message = [NSString stringWithFormat:@"CRASH! OS: %@. Backtrace:\n%@",version, backtrace];

    
    [FlurryAnalytics logError:@"Uncaught" message:message exception:exception];
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
