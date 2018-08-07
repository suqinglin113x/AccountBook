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
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSDictionary *choiceDic;

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
    
    self.type = @"2";
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

- (void)dissMiss {
    [self.inputView fieldResignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - QZPublishNaviTopViewDelegate

- (void)cancelTopClick {
    NSLog(@"cancel");
    [self dissMiss];
}

- (void)saveTopClick {
    NSLog(@"sure");
    self.choiceDic = [self.inputView getChoiceItem];
    NSString *money = self.choiceDic[@"money"];
    if (money.length <= 0 || money.floatValue <= 0) {
        NALog(@"请输入金额");
    }else {
        NSDictionary *dict = @{@"userId":@"1",@"type":self.type,@"time":[QZWidgetTool getCurrentTimes],@"remark":@""};
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:dict];
        [dic addEntriesFromDictionary:self.choiceDic];
        
        [QZNetTool postPublishDataWithParams:dic.mutableCopy block:^(QZBaseModel *baseModel, NSError *error) {
            if (baseModel.code.integerValue == 200) {
                [self dissMiss];
            }
        }];
    }

}

- (void)showPublishTopExpend {
    NSLog(@"00000000000");
    self.inputView.dataArr = kArrayExpend;
    self.type = @"2";
}

- (void)showPublishTopIncome {
    NSLog(@"111111111111");
    self.inputView.dataArr = kArrayIncome;
    self.type = @"1";
}

@end
