//
//  QZPublishViewController.m
//  jizhang
//
//  Created by Adam on 2018/7/31.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZPublishViewController.h"
#import "QZPublishNaviTopView.h"
#import "QZPublishInputView.h"


#define kArrayExpend        @[@"吃喝",@"交通",@"购物",@"住房",@"其他"]
#define kArrayIncome        @[@"工资",@"理财",@"红包",@"其他"]

@interface QZPublishViewController ()<QZPublishNaviTopViewDelegate>

@property (nonatomic, strong) QZPublishNaviTopView *topView;
@property (nonatomic, strong) QZPublishInputView *inputView;

@end

@implementation QZPublishViewController

- (UIView *)inputView {
    if (_inputView == nil) {
        _inputView = [[QZPublishInputView alloc] init];
        _inputView.dataArr = kArrayExpend;
    }
    return _inputView;
}

- (QZPublishNaviTopView *)topView {
    if (_topView == nil) {
        _topView = [[QZPublishNaviTopView alloc] init];
        _topView.delegate = self;
    }
    return _topView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(kNavBarAndStatusBarHeight);
    }];
    
    [self.view addSubview:self.inputView];
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom);
    }];
    
    
}


#pragma mark - QZPublishNaviTopViewDelegate

- (void)cancelTopClick {
    NSLog(@"cancel");
    [self.inputView fieldResignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveTopClick {
    NSLog(@"sure");
}

- (void)showPublishTopExpend {
    NSLog(@"00000000000");
    self.inputView.dataArr = kArrayExpend;
}

- (void)showPublishTopIncome {
    NSLog(@"111111111111");
    self.inputView.dataArr = kArrayIncome;
}

@end
