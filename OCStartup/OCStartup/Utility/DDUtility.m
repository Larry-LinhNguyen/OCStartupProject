//
//  DDUtility.m
//  OCStartup
//
//  Created by Yanchen Wang on 17/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import "DDUtility.h"
#import "DDPageManager.h"

@implementation DDUtility

+ (instancetype)sharedInstance {
    static id _s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _s_instance = [self new];
    });
    return _s_instance;
}

- (void)appInitSetup {
    // setup page mapping
    [[DDPageManager sharedManager] setupPageMapping];
    
    // setup hooks
}

@end
