//
//  QZBillPickView.h
//  jizhang
//
//  Created by Adam on 2018/8/7.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol QZBillPickViewDelegate <NSObject>
- (void)pickWithItem:(NSString *)item;
@end

@interface QZBillPickView : UIView

@property (nonatomic, weak) id<QZBillPickViewDelegate> b_delegate;
@end
