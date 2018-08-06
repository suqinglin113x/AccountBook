//
//  QZNaviTopView.m
//  jizhang
//
//  Created by 邓振娜 on 2018/8/6.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZNaviTopView.h"

#define kWidth      50
#define kWidthAScale        kWidth*kScale
@interface QZNaviTopView ()

@property (nonatomic, strong) UIButton *expendBtn;
@property (nonatomic, strong) UIButton *incomeBtn;
@property (nonatomic, strong) UIView *expendLine;
@property (nonatomic, strong) UIView *incomeLine;
@property (nonatomic, strong) UIView *line;

@end

@implementation QZNaviTopView

- (UIButton *)expendBtn {
    if (_expendBtn == nil) {
        _expendBtn = [QZWidgetTool creatButtonWithText:@"支出" font:16 normalColor:[UIColor colorWithR:102 g:102 b:102] selectColor:[UIColor colorWithR:34 g:34 b:34] target:self action:@selector(didClickButtonExpend:)];
    }
    return _expendBtn;
}

- (UIButton *)incomeBtn {
    if (_incomeBtn == nil) {
        _incomeBtn = [QZWidgetTool creatButtonWithText:@"收入" font:16 normalColor:[UIColor colorWithR:102 g:102 b:102] selectColor:[UIColor colorWithR:34 g:34 b:34] target:self action:@selector(didClickButtonIncome:)];
    }
    return _incomeBtn;
}

- (UIView *)expendLine {
    if (_expendLine == nil) {
        _expendLine = [self creatLineWithColor:kMainColor width:kWidth height:3];
    }
    return _expendLine;
}

- (UIView *)incomeLine {
    if (_incomeLine == nil) {
        _incomeLine = [self creatLineWithColor:kMainColor width:kWidth height:3];
    }
    return _incomeLine;
}

- (UIView *)line {
    if (_line == nil) {
        _line = [self creatLineWithColor:kLineColor width:kScreenWidth height:0.6];
    }
    return _line;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.expendBtn];
        [self addSubview:self.expendLine];
        [self addSubview:self.incomeBtn];
        [self addSubview:self.incomeLine];
        [self addSubview:self.line];
        
        [self didClickButtonExpend:self.expendBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.2*kScale);
    }];
    
    [self.expendLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kWidthAScale);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(3*kScale);
        make.right.equalTo(self.mas_centerX).offset(-kWidthAScale*0.5);
    }];
    
    [self.incomeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.bottom.equalTo(self.expendLine);
        make.left.equalTo(self.mas_centerX).offset(kWidthAScale*0.5);
    }];
    
    [self.expendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.expendLine);
        make.height.mas_equalTo(kNavBarHeigth);
    }];
    
    [self.incomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.incomeLine);
        make.height.equalTo(self.expendBtn);
    }];
}

- (UIView *)creatLineWithColor:(UIColor *)color width:(CGFloat)w height:(CGFloat)h {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w * kScale, h * kScale)];
    line.backgroundColor = color;
    return line;
}


#pragma mark - click
- (void)didClickButtonExpend:(UIButton *)sender {
    
    sender.selected = YES;
    self.incomeBtn.selected = NO;
    self.expendLine.hidden = NO;
    self.incomeLine.hidden = YES;
    if ([self.delegate respondsToSelector:@selector(showExpendChart)]) {
        [self.delegate showExpendChart];
    }
}

- (void)didClickButtonIncome:(UIButton *)sender {
    
    sender.selected = YES;
    self.expendBtn.selected = NO;
    self.expendLine.hidden = YES;
    self.incomeLine.hidden = NO;
    if ([self.delegate respondsToSelector:@selector(showIncomeChart)]) {
        [self.delegate showIncomeChart];
    }
}

@end
