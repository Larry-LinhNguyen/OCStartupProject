//
//  DDMacros.h
//  OCStartup
//
//  Created by Yanchen Wang on 20/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#ifndef DDMacros_h
#define DDMacros_h

#define UIColorFromRGB_dec(r,g,b) [UIColor colorWithRed:r/256.f green:g/256.f blue:b/256.f alpha:1.f]
#define UIColorFromRGBA_dec(r,g,b,a) [UIColor colorWithRed:r/256.f green:g/256.f blue:b/256.f alpha:a]
#define UIColorFromRGB_hex(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

#define UIColorFromRGBA_hex(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#if DEBUG

#define DWLog(fmt, ...) NSLog(@"<%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(fmt), ##__VA_ARGS__])

#else

#define DWLog(fmt, ...) ((void)0)

#endif

#define SelectorDescripation    DWLog(@"%@", NSStringFromSelector(_cmd))

#ifndef UserDefaults
#define UserDefaults            [NSUserDefaults standardUserDefaults]
#endif

#ifndef DefaultNotificationCenter
#define DefaultNotificationCenter       [NSNotificationCenter defaultCenter]
#endif

#define WEAK_SELF_DEFINE(pSelf)        __weak typeof(self) (pSelf) = self
#define STRING_FROM_CLASS(cls)  NSStringFromClass([cls class])

#ifndef DEBUG_INVALIDATE_ARGUMENTS
#define DEBUG_INVALIDATE_ARGUMENTS NSLog(@"%@- %@ : invalidate arguments", NSStringFromClass([self class]), NSStringFromSelector(_cmd))
#endif

#endif /* DDMacros_h */
