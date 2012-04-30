//
//  FacebookController.m
//  DirectDialing
//
//  Created by Itai Ram on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FacebookController.h"

static NSString* kAppId = @"349376771765571";

@implementation FacebookController

@synthesize facebook;

- (void)postToWallWithOptions:(NSDictionary *)options
{
    completionHandler handler = ^(id data)
    {
        // If you want this class to also be the delegate dialog, it will need to implement FBDialogDelegate
       // [facebook dialog:@"feed" andParams:options andDelegate:self];
    };
    [self login:handler];
}

- (void)login:(completionHandler)handler
{
//    completionHandler = handler;
//    // Be sure to add in your permissions here
//    [facebook authorize:yourPermissions delegate:self];
//    [facebook authorize:[NSArray arrayWithObjects:@"publish_stream", delegate:self]];

}

- (void)fbDidLogin
{
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
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Smart Phone" 
                                                    message:@"You successfully shared Smart Phone app on Facebook" 
                                                   delegate:nil 
                                          cancelButtonTitle:@"Dismiss"
                                          otherButtonTitles:nil];
    [alert show];

}


@end
