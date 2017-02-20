//
//  NSAttributedString+ddframework.m
//  OCStartup
//
//  Created by Yanchen Wang on 20/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import <CoreText/CoreText.h>
#import "NSAttributedString+ddframework.h"

@implementation NSAttributedString (ddframework)

- (CGFloat)boundingHeightForWidth:(CGFloat)width {
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFMutableAttributedStringRef) self);
    CGRect box = CGRectMake(0,0, width, CGFLOAT_MAX);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, box);
    
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), NULL, CGSizeMake(width, CGFLOAT_MAX), NULL);
    CFRelease(framesetter);
    CFRelease(path);
    
    return suggestedSize.height;
}

@end
