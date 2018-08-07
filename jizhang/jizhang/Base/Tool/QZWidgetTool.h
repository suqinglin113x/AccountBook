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
+ (NSString *_Nullable)getCurrentTimes;

#pragma mark - control
+ (UILabel *_Nullable)creatLabelWithText:(NSString *_Nullable)text font:(CGFloat)font color:(UIColor *_Nullable)color alignment:(NSTextAlignment)alignment;

+ (UIButton *_Nullable)creatButtonWithText:(NSString *_Nonnull)text font:(CGFloat)font normalColor:(UIColor *_Nonnull)color selectColor:(UIColor *_Nonnull)color target:(nullable id)target action:(SEL _Nonnull )action;

@end
