//
//  MainTabBar.h
//  jizhang
//
//  Created by Adam on 2018/7/31.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainTabBarDelegate <NSObject>
- (void)plusBtnClick;
@end

@interface MainTabBar : UITabBar

@property (nonatomic, weak) id <MainTabBarDelegate>myDelegate;

@end
