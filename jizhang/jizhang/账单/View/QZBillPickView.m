//
//  QZBillPickView.m
//  jizhang
//
//  Created by Adam on 2018/8/7.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZBillPickView.h"

@interface QZBillPickView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) UIPickerView *pickV;

@end
@implementation QZBillPickView
{
    NSArray *titles;
    NSString *item;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setPickData];
        [self setupPickView];
    }
    
    return self;;
}

- (void)setPickData
{
    titles = @[@"吃喝", @"住房", @"购物", @"交通", @"工资", @"红包", @"理财", @"其他"];
}
- (void)setupPickView
{
    
    UIView *shadow = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    shadow.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.6];
    [self addSubview:shadow];
    
    UIPickerView *pick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 250 *kScale, kScreenWidth, 250 *kScale)];
    self.pickV = pick;
    pick.backgroundColor = [UIColor whiteColor];
//    pick.frame = CGRectMake(0, kScreenHeight - 250 *kScale, [UIScreen mainScreen].bounds.size.width, 250 *kScale);
    [shadow addSubview:pick];
    pick.dataSource = self;
    pick.delegate = self;
    [pick selectRow:3 inComponent:0 animated:YES];
    [self pickerView:pick didSelectRow:3 inComponent:0];
    
    UIView *toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, pick.frame.origin.y - 41, kScreenWidth, 40)];
    toolBar.backgroundColor = [UIColor whiteColor];
    [shadow addSubview:toolBar];
    //  设置右上角确定按钮
    UIButton *confirmBtn = [UIButton new];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:UIColorFromHex(0xffde01) forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:confirmBtn];
    confirmBtn.frame = CGRectMake(kScreenWidth - 60, 0, 60, 40);
    
    UIButton *cancleBtn = [UIButton new];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancleBtn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:cancleBtn];
    cancleBtn.frame = CGRectMake(20*kScale, 0, 60, 40);
}

- (void)cancle
{
    [self dismissPick];
}
- (void)confirm
{
    
    if ([self.b_delegate respondsToSelector:@selector(pickWithItem:)]) {
        [self.b_delegate pickWithItem:item];
    }
    [self dismissPick];
}
/** 隐藏pickview*/
- (void)dismissPick
{
    
    [self.pickV.superview removeFromSuperview];
    [self.pickV removeFromSuperview];
    [self removeFromSuperview];
    
    //
    [[NSNotificationCenter defaultCenter] postNotificationName:@"triangle" object:nil];
}
#pragma mark - 时间选择器代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return titles.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return titles[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    item = titles[row];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
    }
    return 50 *kScale;
}



@end
