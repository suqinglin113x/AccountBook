//
//  MainTabBarViewController.m
//  jizhang
//
//  Created by Adam on 2018/7/31.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "MainTabBar.h"
#import "QZBaseNavigationController.h"
#import "QZBillViewController.h"
#import "QZChartViewController.h"
#import "QZPublishViewController.h"
#import "QZFlowViewController.h"
#import "QZMyViewController.h"


@interface MainTabBarViewController () <MainTabBarDelegate>

@property (nonatomic, strong) MainTabBar *mainTabBar;

@end

@implementation MainTabBarViewController

+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self SetupAllControllers];
    // 更换tabBar
    MainTabBar *tabBar = [[MainTabBar alloc] init];
    tabBar.myDelegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
}

- (void)SetupAllControllers
{
    [self addChildVc:[QZBillViewController new] title:@"账单" image:@"bill_normal" selectedImage:@"bill_selected"];
    
    
    [self addChildVc:[QZChartViewController new] title:@"图表" image:@"chart_normal" selectedImage:@"chart_selected"];
    
    [self addChildVc:[QZFlowViewController new] title:@"流水" image:@"chart_normal" selectedImage:@"chart_selected"];
    
    [self addChildVc:[QZMyViewController new] title:@"我的" image:@"mine_normal" selectedImage:@"mine_selected"];
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    QZBaseNavigationController *navi = [[QZBaseNavigationController alloc] initWithRootViewController:childVc];
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.navigationItem.title = title;
    [self addChildViewController:navi];
}

#pragma mark -- MainTabBarDelegate --

- (void)plusBtnClick
{
    QZPublishViewController *pubVC = [QZPublishViewController new];
    pubVC.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:pubVC animated:YES completion:nil];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSLog(@"%@", item.title);
}




@end
