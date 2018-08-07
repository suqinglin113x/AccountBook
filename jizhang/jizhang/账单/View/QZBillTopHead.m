//
//  QZBillTopHead.m
//  jizhang
//
//  Created by Adam on 2018/8/6.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZBillTopHead.h"

@interface QZBillTopHead ()
@property (nonatomic, weak) UIButton *choiceBtn;
@property (nonatomic, weak) UILabel *totalL;
@property (nonatomic, weak) UILabel *dateL;

@end

@implementation QZBillTopHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupTopInteface];
    }
    
    return self;
}

- (void)setupTopInteface
{
    
    
    // 日常
    UIButton *choiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.choiceBtn = choiceBtn;
    [self addSubview:choiceBtn];
    [choiceBtn setImage:[UIImage imageNamed:@"svg_triangle"] forState:UIControlStateNormal];
    [choiceBtn setTitle:@"日常" forState:UIControlStateNormal];
    [choiceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [choiceBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5*kScale, 0, 0)];
    [choiceBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5 *kScale, 0, 0)];
    [choiceBtn addTarget:self action:@selector(choiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 总收入
    UILabel *totalL = [[UILabel alloc] initWithFrame:CGRectMake(0, 70 *kScale, 150 *kScale, 30 *kScale)];
    self.totalL = totalL;
    totalL.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:30 *kScale];
    totalL.text = @"30000.00";
    totalL.textColor = UIColorFromHex(0x333333);
    totalL.textAlignment = 1;
    [self addSubview:totalL];
    
    // 结余时间
    UILabel *dateL = [[UILabel alloc] initWithFrame:CGRectMake(0, totalL.bottom, 150 *kScale, 30 *kScale)];
    self.dateL = dateL;
    dateL.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14 *kScale];
    dateL.text = @"7月结余";
    dateL.textColor = UIColorFromHex(0x333333);
    dateL.textAlignment = 1;
    [self addSubview:dateL];
    
    // 收支状况
    CGFloat w = kScreenWidth / 2.0;
    for (int i = 0; i < 2; i ++) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0+ w*i , dateL.bottom, w, 60 *kScale);
        label.textAlignment = 1;
        label.text = @"100.00\n7月支出";
        label.numberOfLines = 0;
        label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16 *kScale];
        [self addSubview:label];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(w, label.y + label.height *0.5 - 15 *kScale, 1, 30 *kScale)];
        [self addSubview:line];
        line.backgroundColor = [UIColor blackColor];
        
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.choiceBtn.frame = CGRectMake(0, 32 *kScale, 100 *kScale, 30);
    self.choiceBtn.centerX = self.centerX;
    self.totalL.centerX = self.centerX;
    self.dateL.centerX = self.centerX;
}


- (void)setDict:(NSDictionary *)dict
{
    
}

- (void)choiceBtnClick:(id)sender
{
    if ([self.top_delegate respondsToSelector:@selector(choiceItem:)]) {
        [self.top_delegate choiceItem:@""];
    }
    NSLog(@"添加弹窗");
}
@end
