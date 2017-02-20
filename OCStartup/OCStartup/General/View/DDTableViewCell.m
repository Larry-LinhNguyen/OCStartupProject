//
//  DDTableViewCell.m
//  OCStartup
//
//  Created by Yanchen Wang on 17/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import "DDTableViewCell.h"

@implementation DDTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    // Configure the view for the highlighted state
}

- (void)setCellDataObj:(id)cellDataObj {
    _cellDataObj = cellDataObj;
    
    [self updateUI];
    
    [self setNeedsUpdateConstraints];
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (void)updateUI {
    // do nothing
}

+ (CGFloat)cellHeightForCellDataObj:(id)cellDataObj {
    return 40.0f; // defalut height
}

@end
