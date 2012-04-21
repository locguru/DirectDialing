//
//  AppDelegate.h
//  DirectDialing
//
//  Created by Itai Ram on 12/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class ViewController;
@class AccessNumber;
@class Settings;

@interface AppDelegate : UIResponder <UIApplicationDelegate> 

@property (strong, nonatomic) UIWindow *window;
//@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) AccessNumber *accessNumber;
@property (strong, nonatomic) Settings *settingsvc;

void uncaughtExceptionHandler(NSException *exception);

@end
