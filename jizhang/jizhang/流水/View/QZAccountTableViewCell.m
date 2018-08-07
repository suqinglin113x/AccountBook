//
//  QZAccountTableViewCell.m
//  jizhang
//
//  Created by 邓振娜 on 2018/8/7.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZAccountTableViewCell.h"


#define kMargin     10*kScale
#define kFont       14

@interface QZAccountTableViewCell ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation QZAccountTableViewCell

- (UIImageView *)imgView {
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        _imgView.image = [UIImage imageNamed:@"accountLine"];
    }
    return _imgView;
}

- (UILabel *)itemLbl {
    if (_itemLbl == nil) {
        _itemLbl = [QZWidgetTool creatLabelWithText:@"item" font:kFont color:[UIColor blackColor] alignment:NSTextAlignmentLeft];
    }
    return _itemLbl;
}

- (UILabel *)moneyLbl {
    if (_moneyLbl == nil) {
        _moneyLbl = [QZWidgetTool creatLabelWithText:@"0.00" font:kFont color:kMainColor alignment:NSTextAlignmentRight];
    }
    return _moneyLbl;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.imgView];
        [self addSubview:self.itemLbl];
        [self addSubview:self.moneyLbl];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kMargin);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(4 * kScale);
    }];
    
    [self.itemLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(kMargin);
        make.top.bottom.equalTo(self);
    }];
    
    [self.moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.itemLbl.mas_right).offset(kMargin);
        make.right.equalTo(self).offset(-kMargin);
        make.top.bottom.equalTo(self.itemLbl);
    }];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
