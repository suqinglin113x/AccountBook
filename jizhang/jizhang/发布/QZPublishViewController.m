//
//  QZPublishViewController.m
//  jizhang
//
//  Created by Adam on 2018/7/31.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZPublishViewController.h"

@interface QZPublishViewController ()

@end

@implementation QZPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIView *whiteNav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    whiteNav.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteNav];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(15, 20, 60, 30);
    [leftBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [whiteNav addSubview:leftBtn];
    
    
}

- (void)cancleBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}






@end
