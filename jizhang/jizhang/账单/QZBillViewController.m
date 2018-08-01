//
//  QZBillViewController.m
//  jizhang
//
//  Created by Adam on 2018/7/31.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZBillViewController.h"
#import "QZLoginViewController.h"

@interface QZBillViewController ()

@end

@implementation QZBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 自定义nav
    UIButton *leftItem = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [leftItem addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    leftItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftItem.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [leftItem setImage:[UIImage imageNamed:@"book"] forState:UIControlStateNormal];
    
    UIButton *rightItem1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    [rightItem1 addTarget:self action:@selector(rightItem1Click) forControlEvents:UIControlEventTouchUpInside];
    rightItem1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightItem1 setImage:[UIImage imageNamed:@"book"] forState:UIControlStateNormal];
    
    UIButton *rightItem2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    [rightItem2 addTarget:self action:@selector(rightItem2Click) forControlEvents:UIControlEventTouchUpInside];
    rightItem2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightItem2 setImage:[UIImage imageNamed:@"book"] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftItem];
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:rightItem1], [[UIBarButtonItem alloc] initWithCustomView:rightItem2] ];
    
    UIView *redV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200 *kScale)];
    [self.view addSubview:redV];
    redV.backgroundColor = [UIColor redColor];
    
    
    
}

#pragma mark - action
- (void)leftItemClick
{
    //1未登录
    QZLoginViewController *loginV = [QZLoginViewController new];
    [self.navigationController pushViewController:loginV animated:YES];
    
    //2已登录
    
    NSLog(@"请选择账单");
}

- (void)rightItem1Click
{
    NSLog(@"共享账本");
}

- (void)rightItem2Click
{
    NSLog(@"日历");
}





@end
