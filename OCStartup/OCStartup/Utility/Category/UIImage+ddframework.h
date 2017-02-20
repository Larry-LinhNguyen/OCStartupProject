//
//  UIImage+ddframework.h
//  OCStartup
//
//  Created by Yanchen Wang on 20/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ddframework)

+ (UIImage*)imageFromView:(UIView*)view;
+ (UIImage *)imageWithColor:(UIColor *)aColor;
+ (UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;

@end
