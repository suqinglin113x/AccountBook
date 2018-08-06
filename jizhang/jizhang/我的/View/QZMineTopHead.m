//
//  QZMineTopHead.m
//  jizhang
//
//  Created by Adam on 2018/8/2.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZMineTopHead.h"

@implementation QZMineTopHead

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
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200 *kScale)];
    [self addSubview:headView];
    headView.backgroundColor = UIColorFromHex(0xffde01);
    
    UIImageView *headIv = [[UIImageView  alloc] initWithImage:[UIImage imageNamed:@"touxiang"]];
    [headView addSubview:headIv];
    headIv.bounds = CGRectMake(0, 0, 90 *kScale, 90 *kScale);
    headIv.center = CGPointMake(headView.centerX - 10*kScale, headView.centerY - 20 *kScale);
    headIv.layer.cornerRadius = headIv.width *0.5;
    headIv.layer.masksToBounds = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, headIv.bottom, kScreenWidth *0.7, 60 *kScale)];
    label.centerX = headView.centerX;
    label.textColor = [UIColor whiteColor];
    
    label.font = [UIFont systemFontOfSize:15 *kScale];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:@"手机用户9965\n欢迎来到奇子簿的第3天"];
    NSRange range = [attri.string rangeOfString:@"\n"];
    [attri addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12 *kScale]} range:NSMakeRange(range.location, attri.length -1 - range.location)];
    label.attributedText = attri;
    label.numberOfLines = 2;
    label.textAlignment = 1;
    [headView addSubview:label];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewClick)];
    [headView addGestureRecognizer:tap];
    
    UIView *bottomV = [[UIView alloc] initWithFrame:CGRectMake(0, headView.bottom, kScreenWidth, 100 *kScale)];
    [self addSubview:bottomV];
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

- (void)headViewClick
{
    NSLog(@"去换头像了");
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

