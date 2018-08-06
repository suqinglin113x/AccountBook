//
//  QZPickView.m
//  jizhang
//
//  Created by Adam on 2018/8/3.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZPickView.h"

#import <UserNotifications/UserNotifications.h>

@interface QZPickView () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, weak) UIPickerView *pickV;

@end

@implementation QZPickView
{
    int hour;
    int minute;
    NSArray *title1s;
    NSMutableArray *title2s;
    NSMutableArray *title3s;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupPickView];
        [self setPickData];
    }
    
    return self;;
}

- (void)setPickData
{
    title1s = @[@"上午", @"下午"];
    title2s = [NSMutableArray array];
    for (int i = 0; i < 24; i ++) {
        [title2s addObject:[NSString stringWithFormat:@"%02d", i]];
    }
    title3s = [NSMutableArray array];
    for (int i = 0; i < 60; i ++) {
        [title3s addObject:[NSString stringWithFormat:@"%02d", i]];
    }
}
- (void)setupPickView
{
    self.layer.cornerRadius = 10;
    self.backgroundColor = [UIColor lightGrayColor];
    
    
    UIPickerView *pick = [[UIPickerView alloc] init];
    self.pickV = pick;
    pick.backgroundColor = [UIColor whiteColor];
    pick.frame = CGRectMake(0, self.height - 200 *kScale, [UIScreen mainScreen].bounds.size.width, 200 *kScale);
    [self addSubview:pick];
    UIWindow *key = [UIApplication sharedApplication].keyWindow;
    key.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.6];
    [key addSubview:self];
    
    pick.dataSource = self;
    pick.delegate = self;
    
    //  设置右上角确定按钮
    UIButton *confirmBtn = [UIButton new];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmBtn];
    confirmBtn.frame = CGRectMake(300, pick.frame.origin.y - 30, 60, 30);
}

/** 隐藏pickview*/
- (void)dismissPick
{
    [self.pickV.superview removeFromSuperview];
    [self.pickV removeFromSuperview];
    self.pickV = nil;
}
/** 确定*/
- (void)confirm
{
    [self dismissPick];
    if ([self.p_delegate respondsToSelector:@selector(pickWithHour:minute:  )]) {
        [self.p_delegate pickWithHour:hour minute:minute];
    }
}

#pragma mark - 时间选择器代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component ==0) {
        return title1s.count;
    } else if (component == 1) {
        return title2s.count;
    } else {
        return title3s.count;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (component == 0) {
        return title1s[row];
    }
    if (component == 1) {
        return title2s[row];
    }
    if (component == 2) {
        return title3s[row];
    }
    return nil;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 1) {
        hour = [title2s[row] intValue];
    }
    if (component == 2) {
        NSLog(@"******");
        minute = [title3s[row] intValue];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissPick];
}
@end
