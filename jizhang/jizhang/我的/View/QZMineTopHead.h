//
//  QZMineTopHead.h
//  jizhang
//
//  Created by Adam on 2018/8/2.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QZMineTopHeadDelegate <NSObject>
- (void)toLogin;

@end

@interface QZMineTopHead : UIView

@property (nonatomic, copy) void (^setingBlock)(NSInteger k_index);
@property (nonatomic, weak) id <QZMineTopHeadDelegate> m_delegate;
@end

@interface QZMineBottom : UIView


@end
