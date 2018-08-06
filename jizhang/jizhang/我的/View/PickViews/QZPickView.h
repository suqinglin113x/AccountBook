//
//  QZPickView.h
//  jizhang
//
//  Created by Adam on 2018/8/3.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QZPickViewDelegate <NSObject>
- (void)pickWithHour:(int)hour minute:(int)minute;
@end

@interface QZPickView : UIView

@property (nonatomic, weak) id<QZPickViewDelegate> p_delegate;
@end
