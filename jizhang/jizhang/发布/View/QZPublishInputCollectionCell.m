//
//  QZPublishInputCollectionCell.m
//  jizhang
//
//  Created by 邓振娜 on 2018/8/6.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZPublishInputCollectionCell.h"

@interface QZPublishInputCollectionCell ()

@end

@implementation QZPublishInputCollectionCell

- (UIImageView *)iconView {
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.backgroundColor = [UIColor clearColor];
    }
    return _iconView;
}

- (UILabel *)titleLbl {
    if (_titleLbl == nil) {
        _titleLbl = [QZWidgetTool creatLabelWithText:@"title" font:12 color:[UIColor colorWithR:102 g:102 b:102] alignment:NSTextAlignmentCenter];
    }
    return _titleLbl;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconView];
        [self addSubview:self.titleLbl];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-15*kScale);
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleLbl.mas_top).offset(-5*kScale);
        make.width.height.mas_equalTo(35 * kScale);
        make.centerX.equalTo(self);
    }];
}

@end
