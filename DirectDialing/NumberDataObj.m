//
//  NumberDataObj.m
//  DirectDialing
//
//  Created by Itai Ram on 3/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NumberDataObj.h"

@implementation NumberDataObj 

@synthesize inputNum;
@synthesize inputName;

- (id)init
{
    self = [super init];
    
    if (self != nil) {
        inputNum = [[NSString alloc] init];
        inputName = [[NSString alloc] init];
    }
    
    return self;
}

@end
