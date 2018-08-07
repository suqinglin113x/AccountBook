/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>


@interface UIViewController (HUD)

- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)hideHud;
- (void)hideHudWith:(UIView *)view;

- (void)showHint:(NSString *)hint;
- (void)showHint:(NSString *)hint view:(UIView *)view;
- (void)showHint:(NSString *)hint yOffset:(float)yOffset view:(UIView *)view;
// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;
- (void)showHint:(NSString *)hint yOffset:(float)yOffset andAfterDelay:(NSTimeInterval)delay view:(UIView *)view;

@end

@interface UIViewController (Log)

@end
