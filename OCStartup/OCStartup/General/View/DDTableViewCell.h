//
//  DDTableViewCell.h
//  OCStartup
//
//  Created by Yanchen Wang on 17/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDTableViewCell : UITableViewCell

@property (nonatomic, strong) id cellDataObj;

// override for subclass
- (void)updateUI;
+ (CGFloat)cellHeightForCellDataObj:(id)cellDataObj;

@end
