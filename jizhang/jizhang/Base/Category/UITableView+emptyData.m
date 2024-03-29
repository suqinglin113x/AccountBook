//
//  UITableView+emptyData.m
//  jizhang
//
//  Created by Adam on 2018/8/3.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "UITableView+emptyData.h"
#import <objc/runtime.h>

@interface UITableView ()
@property (nonatomic, strong) UIView *noDataV;

@end
@implementation UITableView (emptyData)


- (void)showNoDataViewImg:(NSString *)imageName text:(NSString *)hint btn:(NSString *)btnTitle
{
     self.noDataV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.height)];
    self.noDataV.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.noDataV];
    
    UIButton *imageView = [[UIButton alloc] init];
    imageView.frame = CGRectMake(0, 50 *kScale, 100, 100);
    imageView.centerX = self.centerX;
    [imageView setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.noDataV addSubview:imageView];
    
    UILabel *aRowSmallText = [[UILabel alloc] init];
    aRowSmallText.text = hint;
    aRowSmallText.textAlignment = 1;
    aRowSmallText.frame = CGRectMake(0, imageView.bottom + 20 *kScale, 300, 30);
    aRowSmallText.centerX = self.centerX;
    aRowSmallText.font = [UIFont systemFontOfSize:14 *kScale];
    aRowSmallText.textColor = UIColorFromHex(0x999999);
    [self.noDataV addSubview:aRowSmallText];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, aRowSmallText.bottom + 50 *kScale, 170  *kScale, 40 *kScale);
    btn.centerX = self.centerX;
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:16 *kScale]];
    btn.layer.cornerRadius = 4;
    [btn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = UIColorFromHex(0xffde01);
    [self.noDataV addSubview:btn];
}
- (void)hideNoDataView
{
    if (self.noDataV) {
        [self.noDataV removeFromSuperview];
        self.noDataV = nil;
    }
}

- (void)login
{
    if ([self.no_delegate respondsToSelector:@selector(toLogin)]) {
        [self.no_delegate toLogin];
    }
}

- (void)refreshData
{
    [self reloadData];
    NSLog(@"重新刷新");
}


- (void)setNoDataV:(UIView *)noDataV
{
    objc_setAssociatedObject(self, @"nodata", noDataV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)noDataV
{
    return objc_getAssociatedObject(self, @"nodata");
}

- (void)setNo_delegate:(id<UITableViewNoDataDelegate>)no_delegate
{
    objc_setAssociatedObject(self, @"no_dele", no_delegate, OBJC_ASSOCIATION_ASSIGN);
}
- (id<UITableViewNoDataDelegate>)no_delegate
{
    return objc_getAssociatedObject(self, @"no_dele");
}


//无数据
- (void)showNoDataViewImg:(NSString *)imageName text:(NSString *)title {
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:imageName];
    [self addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-50 * kScale);
        make.width.height.mas_equalTo(116 * kScale);
    }];
    
    UILabel *titleLbl = [QZWidgetTool creatLabelWithText:kNoData font:14 color:[UIColor colorWithR:153 g:153 b:153] alignment:NSTextAlignmentCenter];
    [self addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imgView);
        make.top.equalTo(imgView.mas_bottom).offset(15 * kScale);
        make.height.mas_equalTo(20 * kScale);
    }];

}

//删除无数据页面
- (void)removeNoDataView {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIImageView class]] || [view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}
@end
