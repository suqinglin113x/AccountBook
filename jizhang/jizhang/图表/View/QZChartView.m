//
//  QZChartView.m
//  jizhang
//
//  Created by 邓振娜 on 2018/8/6.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZChartView.h"
#import "PNChart.h"


#define kMargin     15*kScale
#define kColorText      [UIColor colorWithR:170 g:170 b:170]
#define kArrayExpend    @[@"吃喝",@"住房",@"购物",@"交通",@"其他"]
#define kArrayIncome    @[@"工资",@"红包",@"理财",@"其他"]
@interface QZChartView ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *topLbl;
@property (nonatomic, strong) UILabel *totalMLbl;
@property (nonatomic, strong) UILabel *tCountLbl;
@property (nonatomic, strong) UILabel *pMaxLbl;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) PNBarChart *barChart;

@property (nonatomic, strong) UILabel *bottomLbl;
@property (nonatomic, assign) CGRect originalFrame;

@end

@implementation QZChartView

- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 350 * kScale)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UILabel *totalLbl = [QZWidgetTool creatLabelWithText:@"支出排行榜" font:12 color:[UIColor blackColor] alignment:NSTextAlignmentLeft];
        [_bottomView addSubview:totalLbl];
        [totalLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(_bottomView).offset(kMargin);
            make.right.equalTo(_bottomView).offset(-kMargin);
        }];
        self.bottomLbl = totalLbl;
        
        [_bottomView addSubview:self.barChart];
        [self.barChart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(totalLbl);
            make.right.equalTo(_bottomView);
            make.top.equalTo(totalLbl.mas_bottom);
            make.bottom.equalTo(_bottomView).offset(-kMargin*2);
        }];
    }
    return _bottomView;
}

- (PNBarChart *)barChart {
    if (_barChart == nil) {
        _barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, kMargin*3, kScreenWidth, 250 * kScale)];
        
        _barChart.backgroundColor = [UIColor whiteColor];
        
        //Y坐标label宽度(微调)
//        _barChart.showLevelLine = NO;
//        _barChart.yChartLabelWidth = 20.0 * kScale;
//        _barChart.chartMarginLeft = 10.0 * kScale;
//        _barChart.chartMarginRight = 10.0 * kScale;
//        _barChart.chartMarginTop = 5.0 * kScale;
//        _barChart.chartMarginBottom = 10.0 * kScale;
        //X坐标刻度的上边距
        _barChart.labelMarginTop = 25.0 * kScale;
        //柱子宽度
        _barChart.barWidth = 35 * kScale;
        //是否显示坐标轴
        _barChart.showChartBorder = YES;
        [_barChart setXLabels:kArrayExpend];
        [_barChart setYValues:@[@0,@0,@0,@0,@0]];
//        [_barChart setYValues:@[@220,@20,@440,@60,@0]];
        //每个柱子的颜色
        _barChart.strokeColor = kMainColor;
        //是否立体效果
        _barChart.isGradientShow = NO;
        //显示各条状图的数值
        _barChart.isShowNumbers = NO;
//        //开始绘图
//        [_barChart strokeChart];
    }
    return _barChart;
}

- (UILabel *)totalMLbl {
    if (_totalMLbl == nil) {
        _totalMLbl = [QZWidgetTool creatLabelWithText:@"0.00元" font:36 color:kMainColor alignment:NSTextAlignmentCenter];
    }
    return _totalMLbl;
}
- (UILabel *)tCountLbl {
    if (_tCountLbl == nil) {
        _tCountLbl = [QZWidgetTool creatLabelWithText:@"0笔" font:18 color:kMainColor alignment:NSTextAlignmentCenter];
    }
    return _tCountLbl;
}
- (UILabel *)pMaxLbl {
    if (_pMaxLbl == nil) {
        _pMaxLbl = [QZWidgetTool creatLabelWithText:@"0.00元" font:18 color:kMainColor alignment:NSTextAlignmentCenter];
    }
    return _pMaxLbl;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 188 * kScale)];
        _topView.backgroundColor = [UIColor whiteColor];
        
        UILabel *totalLbl = [QZWidgetTool creatLabelWithText:@"支出总额" font:12 color:[UIColor blackColor] alignment:NSTextAlignmentLeft];
        [_topView addSubview:totalLbl];
        [totalLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(_topView).offset(kMargin);
            make.right.equalTo(_topView).offset(-kMargin);
        }];
        self.topLbl = totalLbl;

        [_topView addSubview:self.totalMLbl];
        [self.totalMLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(totalLbl.mas_bottom).offset(2*kMargin);
            make.left.right.equalTo(totalLbl);
        }];

        UILabel *totalCLbl = [QZWidgetTool creatLabelWithText:@"累计记账" font:11 color:kColorText alignment:NSTextAlignmentCenter];
        [_topView addSubview:totalCLbl];
        [totalCLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.totalMLbl);
            make.top.equalTo(self.totalMLbl.mas_bottom).offset(kMargin*2);
            make.right.equalTo(_topView.mas_centerX);
        }];

        [_topView addSubview:self.tCountLbl];
        [self.tCountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(totalCLbl.mas_bottom).offset(5*kScale);
            make.left.right.equalTo(totalCLbl);
        }];

        UILabel *perMaxLbl = [QZWidgetTool creatLabelWithText:@"单笔最大金额" font:11 color:kColorText alignment:NSTextAlignmentCenter];
        [_topView addSubview:perMaxLbl];
        [perMaxLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_topView.mas_centerX);
            make.right.equalTo(self.totalMLbl);
            make.top.equalTo(totalCLbl);
        }];

        [_topView addSubview:self.pMaxLbl];
        [self.pMaxLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(perMaxLbl.mas_bottom).offset(5*kScale);
            make.left.right.equalTo(perMaxLbl);
        }];
        
    }
    return _topView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBgColor;
        [self addSubview:self.topView];
        [self addSubview:self.bottomView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(188 * kScale);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.topView.mas_bottom).offset(kMargin);
    }];
}

- (void)setType:(QZChartType)type {
    _type = type;
    
    switch (type) {
        case 0:
            self.topLbl.text = @"支出总额";
            self.bottomLbl.text = @"支出排行榜";
            [self.barChart setXLabels:kArrayExpend];
            [self.barChart setYValues:@[@0,@0,@0,@0,@0]];
            [self.barChart strokeChart];
            self.originalFrame = self.barChart.frame;
            break;
            
        case 1:
            self.topLbl.text = @"收入总额";
            self.bottomLbl.text = @"收入排行榜";
            [self.barChart setXLabels:kArrayIncome];
            [self.barChart setYValues:@[@0,@0,@0,@0]];
            [self.barChart strokeChart];
            self.originalFrame = self.barChart.frame;
            break;
        default:
            break;
    }
}

- (void)setModel:(QZChartModel *)model {
    _model = model;
    
    if (!model) {
        self.totalMLbl.text = @"0.00元";
        self.tCountLbl.text = @"0笔";
        self.pMaxLbl.text = @"0.00元";
        
        self.barChart.frame = self.originalFrame;
        NSArray *arrM = [NSArray array];
        if (self.type == 0) {
            arrM = @[@0,@0,@0,@0,@0];
        }else {
            arrM = @[@0,@0,@0,@0];
        }
        self.barChart.frame = self.originalFrame;
        [self.barChart setYValues:arrM];
        [self.barChart strokeChart];
        
        return;
    }
    
    self.totalMLbl.text = [NSString stringWithFormat:@"%@元",model.moneyToal];
    self.tCountLbl.text = [NSString stringWithFormat:@"%@笔",model.number];
    self.pMaxLbl.text = [NSString stringWithFormat:@"%@元",model.maxMoney];
    
    NSArray *arrM = [NSArray array];
    if (self.type == 0) {
        arrM = kArrayExpend;
    }else {
        arrM = kArrayIncome;
    }
    NSMutableArray *countM = [NSMutableArray array];
    for (int i = 0; i < arrM.count; i ++) {
        NSString *title = arrM[i];
        __block float count = 0;
        [model.list enumerateObjectsUsingBlock:^(QZChartListModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.item isEqualToString:title]) {
                count = obj.money.floatValue;
            }
        }];
        [countM insertObject:@(count) atIndex:i];
    }
    
    self.barChart.frame = self.originalFrame;
    [self.barChart setYValues:countM.mutableCopy];
    [self.barChart strokeChart];
    
}


@end
