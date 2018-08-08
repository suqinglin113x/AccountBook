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
@property (nonatomic, weak) UILabel *remainL;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changed) name:@"triangle" object:nil];
    
    // 三角号
    UIButton *choiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.choiceBtn = choiceBtn;
    [self addSubview:choiceBtn];
    [choiceBtn setImage:[UIImage imageNamed:@"Triangle-down"] forState:UIControlStateNormal];

    [choiceBtn setTitle:@"日常" forState:UIControlStateNormal];
    [choiceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [choiceBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5*kScale, 0, 0)];
    [choiceBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5 *kScale, 0, 0)];
    [choiceBtn addTarget:self action:@selector(choiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 结余
    UILabel *remainL = [[UILabel alloc] initWithFrame:CGRectMake(0, 70 *kScale, 150 *kScale, 30 *kScale)];
    self.remainL = remainL;
    remainL.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:30 *kScale];
    remainL.text = @"0.00";
    remainL.textColor = UIColorFromHex(0x333333);
    remainL.textAlignment = 1;
    [self addSubview:remainL];
    
    // 结余时间
    UILabel *dateL = [[UILabel alloc] initWithFrame:CGRectMake(0, remainL.bottom, 150 *kScale, 30 *kScale)];
    self.dateL = dateL;
    dateL.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14 *kScale];
    dateL.text = @"0月结余";
    dateL.textColor = UIColorFromHex(0x333333);
    dateL.textAlignment = 1;
    [self addSubview:dateL];
    
    // 收支状况
    CGFloat w = kScreenWidth / 2.0;
    for (int i = 0; i < 2; i ++) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0+ w*i , dateL.bottom, w, 60 *kScale);
        label.textAlignment = 1;
        label.text = @"0.00\n0月支出";
        label.numberOfLines = 0;
        label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16 *kScale];
        [self addSubview:label];
        label.tag = 100 + i;
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
    self.remainL.centerX = self.centerX;
    self.dateL.centerX = self.centerX;
}


- (void)setDict:(NSDictionary *)dict
{
    
    self.remainL.text = dict? [NSString stringWithFormat:@"%.02f",[dict[@"surplus"] floatValue]] : @"0.00";
    
    self.dateL.text = dict? [NSString stringWithFormat:@"%ld月结余", [self getCurrentM]] :@"0月结余";
   
    // 支出
    UILabel *lab1 = [self viewWithTag:100];
    lab1.text = dict? [NSString stringWithFormat:@"%.02f\n%ld月支出", [dict[@"expenditure"] floatValue], (long)[self getCurrentM]] : @"0.00\n0月支出";
   
    // 收入
    UILabel *lab2 = [self viewWithTag:101];
    lab2.text = dict? [NSString stringWithFormat:@"%.02f\n%ld月收入", [dict[@"income"] floatValue], [self getCurrentM]] : @"0.00\n0月收入";
    
}

- (void)setItemTitle:(NSString *)itemTitle
{
    if (itemTitle) {
        self.choiceBtn.hidden = NO;
        [self.choiceBtn setTitle:itemTitle forState:UIControlStateNormal];
    } else {
        self.choiceBtn.hidden = YES;
    }
    
}

- (void)choiceBtnClick:(UIButton *)sender
{
    [self changed];
    if ([self.top_delegate respondsToSelector:@selector(choiceItem)]) {
        [self.top_delegate choiceItem];
    }
}

- (NSInteger)getCurrentM
{
    NSDate *date = [NSDate date];
    NSCalendar *cal = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSInteger month = [cal component:NSCalendarUnitMonth fromDate:date];
    return month;
}

- (void)changed
{
    
    self.choiceBtn.imageView.transform = CGAffineTransformRotate(self.choiceBtn.imageView.transform, M_PI);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"triangle" object:nil];
}
@end
