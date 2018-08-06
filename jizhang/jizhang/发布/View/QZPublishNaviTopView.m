//
//  QZPublishNaviTopView.m
//  jizhang
//
//  Created by 邓振娜 on 2018/8/6.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZPublishNaviTopView.h"

#define kTextColor      [UIColor colorWithR:51 g:51 b:51]

@interface QZPublishNaviTopView ()

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UISegmentedControl *segment;

@end

@implementation QZPublishNaviTopView

- (UIButton *)cancelBtn {
    if (_cancelBtn == nil) {
        _cancelBtn = [QZWidgetTool creatButtonWithText:@"取消" font:15 normalColor:kTextColor selectColor:nil target:self action:@selector(didClickButtonCancel:)];
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn {
    if (_sureBtn == nil) {
        _sureBtn = [QZWidgetTool creatButtonWithText:@"保存" font:15 normalColor:kTextColor selectColor:nil target:self action:@selector(didClickButtonSure:)];
    }
    return _sureBtn;
}

- (UISegmentedControl *)segment {
    if (_segment == nil) {
        NSArray *arr = [NSArray arrayWithObjects:@"支出", @"收入", nil];
        _segment = [[UISegmentedControl alloc] initWithItems:arr];
        
        _segment.tintColor = kMainColor;
        _segment.selectedSegmentIndex = 0;
        [_segment addTarget:self action:@selector(segSelectAtIndex:) forControlEvents:UIControlEventValueChanged];
        _segment.layer.borderColor = kMainColor.CGColor;
        _segment.layer.borderWidth = 1;
        _segment.layer.cornerRadius = 3 * kScale;
        _segment.layer.masksToBounds = YES;
        _segment.width = 160 * kScale;
        _segment.height = 30 * kScale;
    }
    return _segment;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.cancelBtn];
        [self addSubview:self.sureBtn];
        [self addSubview:self.segment];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = kLineColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(0.2 * kScale);
        }];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(160 * kScale);
        make.height.mas_equalTo(30 * kScale);
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-7);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.segment.mas_left).offset(-30 * kScale);
        make.height.top.equalTo(self.segment);
        make.left.equalTo(self);
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.equalTo(self.cancelBtn);
        make.right.equalTo(self);
    }];
    
}

#pragma mark - click
- (void)didClickButtonCancel:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(cancelTopClick)]) {
        [self.delegate cancelTopClick];
    }
}

- (void)didClickButtonSure:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(saveTopClick)]) {
        [self.delegate saveTopClick];
    }
}

- (void)segSelectAtIndex:(UISegmentedControl *)seg {
    NSInteger index = seg.selectedSegmentIndex;
    switch (index) {
        case 0:{
            
            if ([self.delegate respondsToSelector:@selector(showPublishTopExpend)]) {
                [self.delegate showPublishTopExpend];
            }
            break;
        }
            
        case 1:{
            
            if ([self.delegate respondsToSelector:@selector(showPublishTopIncome)]) {
                [self.delegate showPublishTopIncome];
            }
            break;
        }
        default:
            break;
    }
}

@end
