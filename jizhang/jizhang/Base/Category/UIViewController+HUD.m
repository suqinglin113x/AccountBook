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

#import "UIViewController+HUD.h"
#import "NSObject+HUD.h"
#import <objc/runtime.h>
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation UIViewController (HUD)

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)showHudHint:(NSString *)hint{
    [self showHudInView:self.view hint:hint];
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    [self hideHudInView:view];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.label.text = hint;
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    [self setHUD:HUD];
}

- (void)showHint:(NSString *)hint{
    [self showHint:hint yOffset:-1];
}
- (void)showHint:(NSString *)hint view:(UIView *)view{
    [self showHint:hint yOffset:-1 andAfterDelay:2 view:view];
}
- (void)showHint:(NSString *)hint yOffset:(float)yOffset view:(UIView *)view{
    [self showHint:hint yOffset:yOffset andAfterDelay:2 view:view];
}

- (void)showHint:(NSString *)hint yOffset:(float)yOffset{
    [self showHint:hint yOffset:yOffset andAfterDelay:2 view:nil];
}
- (void)showHint:(NSString *)hint yOffset:(float)yOffset andAfterDelay:(NSTimeInterval)delay view:(UIView *)view{
    //显示提示信息
    if(!view){
        view = [[UIApplication sharedApplication].delegate window];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    [hud setMode:MBProgressHUDModeText];
    hud.label.text = hint;
    hud.label.numberOfLines = 0;
    hud.margin = 10.f;
    if(yOffset <= 0){
        hud.offset  = CGPointMake(hud.offset.x, IS_IPHONE_5?200.f:150.f);
    }else{
        hud.offset  = CGPointMake(hud.offset.x, hud.offset.y + yOffset);
    }
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}

- (void)hideHud{
    [self hideHudInView:self.view];
}
- (void)hideHudWith:(UIView *)view{
    for (UIView *subView in view.subviews) {
        if([subView isKindOfClass:[MBProgressHUD class]]){
            [subView removeFromSuperview];
        }
    }
    [[self HUD] hideAnimated:YES];
}
@end


@implementation UIViewController (Log)

+ (void)load
{
    
#ifdef DEBUG
    Method  systemM = class_getInstanceMethod([self class], @selector(viewDidLoad));
    Method changeM = class_getInstanceMethod([self class], @selector(viewDidLoad_Log));
    BOOL isAdd = class_addMethod([self class], @selector(viewDidLoad), method_getImplementation(changeM), method_getTypeEncoding(changeM));
    if (isAdd) {
        // 如果成功 说明类中并不存在这个方法的实现
        class_replaceMethod([self class], @selector(viewDidLoad_Log), method_getImplementation(systemM), method_getTypeEncoding(systemM));
    } else {
        method_exchangeImplementations(systemM, changeM);
    }
#endif
}
- (void)viewDidLoad_Log
{
    [self viewDidLoad_Log];
    NSLog(@"CURRENTVC:%@", NSStringFromClass([self class]));
}
@end
