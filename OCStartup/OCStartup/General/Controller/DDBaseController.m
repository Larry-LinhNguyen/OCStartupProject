//
//  DDBaseController.m
//  OCStartup
//
//  Created by Yanchen Wang on 17/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import "DDBaseController.h"
#import "DDGlobal.h"
#import "DDNetwork.h"

@interface DDBaseController ()

@property (nonatomic, strong) NSMutableArray *noti_observers;

@end

@implementation DDBaseController

+ (instancetype)controllerLoadFromXib {
    return [[self alloc] initWithNibName:STRING_FROM_CLASS(self) bundle:nil];
}

- (void)setupPageQueryDic:(NSDictionary *)queryData {
    self.pageQueryData = queryData;
}

- (void)dealloc {
    [DefaultNotificationCenter removeObserver:self];
    for (id obs in self.noti_observers) {
        [DefaultNotificationCenter removeObserver:obs];
    }
    self.noti_observers = nil;
}

- (NSMutableArray *)pi_observers {
    if (!_noti_observers) {
        _noti_observers = [[NSMutableArray alloc] init];
    }
    return _noti_observers;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!self.shouldHideNavigationBar && (!self.parentViewController || [self.parentViewController isKindOfClass:[UINavigationController class]])) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self cancelRequestWhenDisappear];
}

- (id)dd_addObserverForName:(NSString *)name object:(id)obj queue:(NSOperationQueue *)queue usingBlock:(void (^)(NSNotification *))block {
    
    id obsObj = [DefaultNotificationCenter addObserverForName:name object:obj queue:queue usingBlock:block];
    
    if (obsObj) {
        [self.noti_observers addObject:obsObj];
    }
    
    return obsObj;
}

- (void)cancelRequestWhenDisappear {
    // todo :
    [[DDNetwork sharedInstance] cancelRequestWithRequestObject:self.currentPageRequestObj];
}

@end
