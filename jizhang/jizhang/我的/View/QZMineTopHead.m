//
//  QZMineTopHead.m
//  jizhang
//
//  Created by Adam on 2018/8/2.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZMineTopHead.h"

@implementation QZMineTopHead

{
    UILabel *label;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200 *kScale)];
    [self addSubview:headView];
    headView.image = [UIImage  imageNamed:@"个人中心背景"];
    headView.backgroundColor = UIColorFromHex(0xffde01);
    headView.userInteractionEnabled = YES;
    
    UIImageView *headIv = [[UIImageView alloc] init];
    [headView addSubview:headIv];
    headIv.bounds = CGRectMake(0, 0, 90 *kScale, 90 *kScale);
    headIv.center = CGPointMake(headView.centerX - 10*kScale, headView.centerY - 20 *kScale);
    headIv.layer.cornerRadius = headIv.width *0.5;
    headIv.layer.masksToBounds = YES;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, headIv.bottom, kScreenWidth *0.7, 60 *kScale)];
    label.centerX = headView.centerX;
    label.textColor = UIColorFromHex(0x333333);
    label.font = [UIFont fontWithName:@"HelveticaInserat-Roman-SemiB" size:35 *kScale];
    
    // 取userID
    NSString *statusStr;
    if ([[NSUserDefaults standardUserDefaults] valueForKey:USERID_KEY])  {
        // 已登录
        statusStr =  @"小奇\n欢迎来到记账簿";
    } else {
        // 未登录
        statusStr = @"立即登录\n";
    }
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:statusStr];
    NSRange range = [attri.string rangeOfString:@"\n"];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 8 *kScale;
    [attri addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attri.length)];
    [attri addAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFang-SC-Regular" size:15 *kScale]} range:NSMakeRange(range.location, attri.length - range.location)];
    label.attributedText = attri;
    label.numberOfLines = 2;
    label.textAlignment = 1;
    [headView addSubview:label];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewClick)];
    [headView addGestureRecognizer:tap];
    
    UIView *bottomV = [[UIView alloc] initWithFrame:CGRectMake(0, headView.bottom, kScreenWidth, 100 *kScale)];
//    [self addSubview:bottomV];
    bottomV.backgroundColor = [UIColor whiteColor];
    
    NSArray *source = @[@"记账设置", @"预算设置", @"jizhangshezhi", @"yusuanshezhi"];
    for (NSInteger i = 0; i <2; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:source[i + 2]] forState:UIControlStateNormal];
        [btn setTitle:source[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0 + i *kScreenWidth *0.5, 0, kScreenWidth *0.5, bottomV.height);
        btn.tag = i;
        [btn addTarget:self action:@selector(toSetting:) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12 *kScale]];
        [bottomV addSubview:btn];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(5 ,-btn.imageView.frame.size.width, -btn.imageView.frame.size.height,0.0)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.height - 10, 0.0,0.0, -btn.titleLabel.bounds.size.width)];
    }
    
    
}

- (void)topWithStatus:(NSString *)statusStr
{
    
}
- (void)headViewClick
{
    NSLog(@"去登录了");
    
    if ([self.m_delegate respondsToSelector:@selector(toLogin)]) {
        [self.m_delegate toLogin];
    }
}

/** 0:记账设置 1: 预算设置*/
- (void)toSetting:(UIButton *)btn
{
    if (self.setingBlock) {
        self.setingBlock(btn.tag);
    }
}

@end


@implementation QZMineBottom

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (NSInteger i = 0; i < 3; i ++) {
        UIView *itemV = [[UIView alloc] initWithFrame:CGRectZero];
        UIImageView *imgV = [[UIImageView alloc] init];
        [itemV addSubview:imgV];
        
    }
}

@end

