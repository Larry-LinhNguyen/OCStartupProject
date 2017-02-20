//
//  DDModelResponse.m
//  OCStartup
//
//  Created by Yanchen Wang on 20/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import "DDModelResponse.h"

@implementation DDModelResponse

- (instancetype)initWithResultData:(id)resultData {
    if (self = [self init]) {
        self.dataObj = resultData;
    }
    return self;
}

- (void)setDataObj:(id)dataObj {
    _dataObj = dataObj;
    // todo: pharse data
}

@end
