//
//  QZBaseNavigationController.m
//  jizhang
//
//  Created by Adam on 2018/8/1.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZBaseNavigationController.h"

@interface QZBaseNavigationController ()

@end

@implementation QZBaseNavigationController

+ (void)initialize
{
    [UINavigationBar appearance].tintColor = [UIColor blackColor];
    [UINavigationBar appearance].barTintColor = UIColorFromHex(0xffde01);
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:17 *kScale]};
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.translucent = NO;
    
    [self getSubViews:self.navigationBar];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 44, 44);
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    [self popViewControllerAnimated:YES];
}


- (void)popAction:(UIBarButtonItem *)barButtonItem
{
    NSLog(@"返回");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getSubViews:(UIView *)view {
    for (UIView *subView in view.subviews) {
        if (subView.subviews.count) {
            [self getSubViews:subView];
        } else {
            if (subView.frame.size.height <= 1) {
                NSLog(@"----%@", subView);
                //  <UIImageView: 0x7fa5b3500000; frame = (0 64; 375 0.5); userInteractionEnabled = NO; layer = <CALayer: 0x60000002be80>>
                // iOS10 之前
                [subView removeFromSuperview];
                // iOS10
                  subView.hidden = YES;
            }
        }
    }
}
@end
