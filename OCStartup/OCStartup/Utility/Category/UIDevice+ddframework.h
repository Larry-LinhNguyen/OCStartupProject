//
//  UIDevice+ddframework.h
//  OCStartup
//
//  Created by Yanchen Wang on 20/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (ddframework)

- (NSString *)platformString;

+ (BOOL)isRetina;
+ (CGSize)screenSize;
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;

+ (BOOL)isJailbroken;
+ (BOOL)isIPhonePlus;
+ (BOOL)isIPhone4OrEarlier;

@end
