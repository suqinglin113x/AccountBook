//
//  QZAccountHeaderView.m
//  jizhang
//
//  Created by 邓振娜 on 2018/8/6.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZAccountHeaderView.h"

#define kMargin     10*kScale

@interface QZAccountHeaderView ()

@property (nonatomic, strong) UILabel *expendLbl;
@property (nonatomic, strong) UILabel *incomeLbl;
@property (nonatomic, strong) UILabel *surplusLbl;

@end

@implementation QZAccountHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"accountBg"];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    
    UILabel *leftLbl = [QZWidgetTool creatLabelWithText:@"总支出" font:10 color:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    UILabel *centerLbl = [QZWidgetTool creatLabelWithText:@"总收入" font:10 color:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    UILabel *rightLbl = [QZWidgetTool creatLabelWithText:@"结余" font:10 color:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    
    [self addSubview:leftLbl];
    [leftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kMargin);
        make.left.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.33);
    }];
    
    [self addSubview:centerLbl];
    [centerLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.equalTo(leftLbl);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self addSubview:rightLbl];
    [rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.equalTo(leftLbl);
        make.right.equalTo(self);
    }];
    
    
    UILabel *expendLbl = [QZWidgetTool creatLabelWithText:@"0.00" font:10 color:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    UILabel *incomeLbl = [QZWidgetTool creatLabelWithText:@"0.00" font:10 color:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    UILabel *surplusLbl = [QZWidgetTool creatLabelWithText:@"0.00" font:10 color:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    
    [self addSubview:expendLbl];
    [expendLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(leftLbl);
        make.top.equalTo(leftLbl.mas_bottom).offset(2 * kScale);
        make.bottom.equalTo(self).offset(-kMargin);
    }];
    self.expendLbl = expendLbl;
    
    [self addSubview:incomeLbl];
    [incomeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.equalTo(centerLbl);
        make.top.bottom.equalTo(self.expendLbl);
    }];
    self.incomeLbl = incomeLbl;
    
    [self addSubview:surplusLbl];
    [surplusLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.expendLbl);
        make.right.width.equalTo(rightLbl);
    }];
    self.surplusLbl = surplusLbl;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor whiteColor];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftLbl);
        make.bottom.equalTo(self.expendLbl);
        make.width.mas_equalTo(0.8*kScale);
        make.right.equalTo(centerLbl.mas_left);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor whiteColor];
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(line);
        make.left.equalTo(centerLbl.mas_right);
    }];
    
}

- (void)setModel:(QZAccountModel *)model {
    _model = model;
    
    self.expendLbl.text = model.expenditure;
    self.incomeLbl.text = model.income;
    self.surplusLbl.text = model.surplus;
}

@end
