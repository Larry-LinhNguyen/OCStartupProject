//
//  DDModelResponse.h
//  OCStartup
//
//  Created by Yanchen Wang on 20/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDModelResponse : NSObject

@property (nonatomic, strong) id dataObj;
@property (nonatomic, strong) id pharsedDataObj;

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) NSError *error;

- (instancetype)initWithResultData:(id)resultData;

@end
