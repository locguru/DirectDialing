//
//  FacebookController.h
//  DirectDialing
//
//  Created by Itai Ram on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Facebook.h"

typedef void (^completionHandler)(id);

@interface FacebookController : NSObject <FBSessionDelegate>
{
    completionHandler handler;
    Facebook *facebook;

}

@property (nonatomic, retain) Facebook *facebook;

- (void)postToWallWithOptions:(NSDictionary *)options;
- (void)login:(completionHandler)handler;
- (void)fbDidLogin;

@end