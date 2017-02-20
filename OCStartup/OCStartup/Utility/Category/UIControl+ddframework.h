//
//  UIControl+ddframework.h
//  OCStartup
//
//  Created by Yanchen Wang on 20/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UIControlBlock)(UIControl *control);

@interface UIControl (ddframework)

- (void)addActionBlock:(UIControlBlock)actionBlock forControlEvents:(UIControlEvents)event;
- (void)setActionBlock:(UIControlBlock)actionBlock forControlEvents:(UIControlEvents)event;

@end
