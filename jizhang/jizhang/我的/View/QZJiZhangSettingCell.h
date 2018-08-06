//
//  QZJiZhangSettingCell.h
//  jizhang
//
//  Created by Adam on 2018/8/3.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QZJiZhangSettingCell : UITableViewCell

@property (nonatomic, weak) UISwitch *switchB;

- (void)setTitle:(NSString *)title detail:(NSString *)detail index:(NSUInteger)index;
@end
