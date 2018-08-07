//
//  QZRegisterViewController.m
//  jizhang
//
//  Created by Adam on 2018/8/1.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZRegisterViewController.h"
#import <MBProgressHUD.h>

@interface QZRegisterViewController () <UITextFieldDelegate>

@end

@implementation QZRegisterViewController
{
    NSString *mobileNum;
    NSString *pasNum;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"注册";
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    NSArray *placeTexts = @[@"请输入手机号", @"设置密码"];
    CGFloat h = 60 *kScale;
    
    for (NSInteger i = 0; i < 2; i ++) {
        UITextField *textF = [[UITextField alloc] init];
        textF.backgroundColor = [UIColor whiteColor];
        textF.placeholder = placeTexts[i];
        textF.tag = i;
        textF.frame = CGRectMake(5*kScale, 15 *kScale + i *(h +1), kScreenWidth - 10 *kScale *kScale, h);
        textF.clearButtonMode = UITextFieldViewModeWhileEditing;
        textF.delegate = self;
        [self.view addSubview:textF];
        textF.tag = 100 + i;
        if (i == 1) {
            UIButton *eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            eyeBtn.bounds = CGRectMake(0, 0, 50*kScale, 30 *kScale);
            [eyeBtn setImage:[UIImage imageNamed:@"eyeclose"] forState:UIControlStateNormal];
            [eyeBtn addTarget:self action:@selector(eyeClick:) forControlEvents:UIControlEventTouchUpInside];
            textF.rightView = eyeBtn;
            textF.rightViewMode = UITextFieldViewModeAlways;
            textF.secureTextEntry = YES;
        }
        
    }
    
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.frame = CGRectMake(20 *kScale, 10 *kScale + 2 *h + 30 *kScale, kScreenWidth - 40 *kScale, 45 *kScale);
    registBtn.backgroundColor = UIColorFromHex(0xffde01);
    registBtn.layer.cornerRadius = 5 *kScale;
    [registBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [registBtn.titleLabel setFont:[UIFont systemFontOfSize:15 *kScale]];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
}

/** 小燕*/
- (void)eyeClick:(UIButton *)eyeBtn
{
    eyeBtn.selected = !eyeBtn.selected;
    [eyeBtn setImage: [UIImage imageNamed:@"eye"] forState:UIControlStateSelected];
    UITextField *texF = [self.view viewWithTag:101];
    if (eyeBtn.selected) {
        texF.secureTextEntry = NO;
    } else {
        texF.secureTextEntry = YES;
    }
}

/** 注册*/
- (void)registBtnClick
{
    [self.view endEditing:YES];
    
    if (mobileNum.length <= 0 ) {
        [self showHint:@"请输入手机号"];
        return;
    }
    if (pasNum.length == 0) {
        [self showHint:@"请输入密码"];
        return;
    }
    
    
    NSString *url = @"http://192.168.1.185/zhangben/public/api/account/register";
    NSDictionary *dict = @{
                           @"mobile" : mobileNum,
                           @"password" : pasNum
                           };
    [[BaseNetService sharedManager] POST:url parameters:dict success:^(id responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            
            [self showHint:responseObject[@"msg"]];
            NSLog(@"哈哈:%@",responseObject);
        } else {
            [self showHint:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [self showHint:@"网络请求错误,请稍后再试"];
    }];
    
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag - 100 == 0) {
        // 手机号
        mobileNum = textField.text;
    } else if (textField.tag - 100 == 1 ) {
        // pas
        pasNum = textField.text;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
