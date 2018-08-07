//
//  QZWidgetTool.h
//  jizhang
//
//  Created by 邓振娜 on 2018/8/6.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QZWidgetTool : NSObject

//获取当前的时间
+ (NSString *)getCurrentTimes;

#pragma mark - control
+ (UILabel *)creatLabelWithText:(NSString *)text font:(CGFloat)font color:(UIColor *)color alignment:(NSTextAlignment)alignment;

+ (UIButton *)creatButtonWithText:(NSString *)text font:(CGFloat)font normalColor:(UIColor *)color selectColor:(UIColor *)color target:(nullable id)target action:(SEL)action;

@end
