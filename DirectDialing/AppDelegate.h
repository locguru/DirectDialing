//
//  AppDelegate.h
//  DirectDialing
//
//  Created by Itai Ram on 12/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@class AccessNumber;
@class Settings;

@interface AppDelegate : UIResponder <UIApplicationDelegate, FBSessionDelegate, FBRequestDelegate> {
    
    Facebook *facebook;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AccessNumber *accessNumber;
@property (nonatomic, retain) Facebook *facebook;

void uncaughtExceptionHandler(NSException *exception);

@end
