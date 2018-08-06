//
//  QZWidgetTool.m
//  jizhang
//
//  Created by 邓振娜 on 2018/8/6.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZWidgetTool.h"

@implementation QZWidgetTool

+ (UILabel *)creatLabelWithText:(NSString *)text font:(CGFloat)font color:(UIColor *)color alignment:(NSTextAlignment)alignment {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = color;
    label.font = kNAFont(font);
    if (alignment) {
        label.textAlignment = alignment;
    }else {
        label.textAlignment = NSTextAlignmentLeft;
    }
    return label;
}

+ (UIButton *)creatButtonWithText:(NSString *)text font:(CGFloat)font normalColor:(UIColor *)color selectColor:(UIColor *)selectColor target:(nullable id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:text forState:UIControlStateNormal];
    btn.titleLabel.font = kNAFont(font);
//    [btn setTitleColor:color forState:UIControlStateNormal];
//    [btn setTitleColor:selectColor forState:UIControlStateSelected];
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:text];
    [attriString addAttribute:NSFontAttributeName
                        value:kNAFont(font)
                        range:NSMakeRange(0,text.length)];
    [attriString addAttribute:NSForegroundColorAttributeName
                        value:color
                        range:NSMakeRange(0,text.length)];
    [btn setAttributedTitle:attriString forState:UIControlStateNormal];
    
    if (selectColor) {
        NSMutableAttributedString *attriStringS = [[NSMutableAttributedString alloc] initWithString:text];
        [attriStringS addAttribute:NSFontAttributeName
                             value:[UIFont boldSystemFontOfSize:(font+1)*kScale]
                             range:NSMakeRange(0,text.length)];
        [attriStringS addAttribute:NSForegroundColorAttributeName
                             value:selectColor
                             range:NSMakeRange(0,text.length)];
        [btn setAttributedTitle:attriStringS forState:UIControlStateSelected];
    }
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    return btn;
}

@end
