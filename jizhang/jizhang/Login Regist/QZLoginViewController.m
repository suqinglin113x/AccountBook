//
//  QZLoginViewController.m
//  jizhang
//
//  Created by Adam on 2018/8/1.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZLoginViewController.h"
#import "QZRegisterViewController.h"

@interface QZLoginViewController () <UITextFieldDelegate>

@end

@implementation QZLoginViewController
{
    NSString *mobileNum;
    NSString *pasNum;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.title = @"登录";
    UIButton  *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightItem setTitle:@"注册" forState:UIControlStateNormal];
    [rightItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightItem addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    
    [self setupTopUI];
    
//    [self setupBottomQuickLoginUI];
}



- (void)setupTopUI
{
    NSArray *placeTexts = @[@"请输入手机号", @"请输入密码"];
    NSArray *leftTexts = @[@"账号", @"密码"];
    CGFloat h = 60 *kScale;
    for (NSInteger i = 0; i < 2; i ++) {
        UITextField *textF = [[UITextField alloc] init];
        textF.backgroundColor = [UIColor whiteColor];
        textF.placeholder = placeTexts[i];
        textF.tag = i;
        textF.frame = CGRectMake(0, 15 *kScale + i *(h +1), kScreenWidth, h);
        textF.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        UILabel *lab = [[UILabel alloc] init];
        lab.frame = CGRectMake(0, 0, 60 *kScale, 30 *kScale);
        lab.font = [UIFont systemFontOfSize:15 *kScale];
        textF.leftView = lab;
        textF.leftViewMode = UITextFieldViewModeAlways;
        lab.text = leftTexts[i];
        lab.textAlignment = 1;
        [self.view addSubview:textF];
        textF.delegate = self;
        if (i == 1) {
            UIButton *eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            eyeBtn.bounds = CGRectMake(0, 0, 50*kScale, 30 *kScale);
            [eyeBtn setImage:[UIImage imageNamed:@"eyeclose"] forState:UIControlStateNormal];
            [eyeBtn addTarget:self action:@selector(eyeClick:) forControlEvents:UIControlEventTouchUpInside];
            textF.rightView = eyeBtn;
            textF.rightViewMode = UITextFieldViewModeAlways;
            textF.secureTextEntry = YES;
        } else {
            
            textF.keyboardType = UIKeyboardTypeNumberPad;
        }
        
    }
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(20 *kScale, 10 *kScale + 2 *h + 30 *kScale, kScreenWidth - 40 *kScale, 45 *kScale);
    loginBtn.backgroundColor = UIColorFromHex(0xffde01);
    loginBtn.layer.cornerRadius = 5 *kScale;
    [loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    [loginBtn.titleLabel setFont:[UIFont systemFontOfSize:15 *kScale]];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.frame = CGRectMake(0, CGRectGetMaxY(loginBtn.frame), 100, 30 *kScale);
    forgetBtn.centerX = loginBtn.centerX;
    forgetBtn.backgroundColor = [UIColor clearColor];
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetBtn.titleLabel setFont:[UIFont systemFontOfSize:13 *kScale]];
    [forgetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:forgetBtn];
}

- (void)setupBottomQuickLoginUI
{
    UIView *quickLV = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 200 *kScale, kScreenWidth, 200 *kScale)];
    quickLV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:quickLV];
    
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 2 *15, 0.7)];
    lineV.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    [quickLV addSubview:lineV];
    
    UILabel *hintL = [[UILabel alloc] init];
    hintL.center = lineV.center;
    hintL.bounds = CGRectMake(0, 0, 60 *kScale, 30 *kScale);
    hintL.text = @"快捷登录";
    hintL.textAlignment = 1;
    hintL.font = [UIFont systemFontOfSize:12 *kScale];
    hintL.textColor = [UIColor grayColor];
    hintL.backgroundColor = [UIColor clearColor];
    [quickLV addSubview:hintL];
    
    
}
#pragma mark -- action --
/** 注册*/
- (void)registerAction
{
    QZRegisterViewController *registerV = [QZRegisterViewController new];
    [self.navigationController pushViewController:registerV animated:YES];
}

/** 小燕*/
- (void)eyeClick:(UIButton *)eyeBtn
{
    eyeBtn.selected = !eyeBtn.selected;
    [eyeBtn setImage: [UIImage imageNamed:@"eye"] forState:UIControlStateSelected];
    UITextField *texF = [self.view viewWithTag:1];
    if (eyeBtn.selected) {
        texF.secureTextEntry = NO;
    } else {
        texF.secureTextEntry = YES;
    }
}

/** 登录*/
- (void)loginBtnClick
{
    [self.view endEditing:YES];
    
    if (mobileNum.length <= 0 ) {
        [self showHint:@"请检验手机号"];
        return;
    }
    if (pasNum.length == 0) {
        [self showHint:@"请输入密码"];
        return;
    }
    
    NSDictionary *dict = @{
                           @"mobile" : mobileNum,
                           @"password" : pasNum
                           };
    [QZNetTool getLoginDataWithParams:dict block:^(QZLoginBaseModel *baseModel, NSError *error) {
        if (error) {
            [self showHint:kNetError];
            return ;
        }
        
        if (baseModel.code.integerValue == 200) {
            [QZUserDataTool setUserDefaultsValue:baseModel.data.userId forKey:kUserDefaultsId];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [self showHint:baseModel.msg];
        }
    }];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 0) {
        // 手机号
        mobileNum = textField.text;
    } else if (textField.tag== 1 ) {
        // pas
        pasNum = textField.text;
    }
}

/** 忘记密码*/
- (void)forgetBtnClick
{
    
}
@end
