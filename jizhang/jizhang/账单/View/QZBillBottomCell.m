//
//  QZBillBottomCell.m
//  jizhang
//
//  Created by Adam on 2018/8/6.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZBillBottomCell.h"
#import "QZBillModel.h"

@interface QZBillBottomCell ()

@property (nonatomic, weak) UIImageView *iconV;

@property (nonatomic, weak) UILabel *titleL;

@property (nonatomic, weak) UILabel *detailL;
@end
@implementation QZBillBottomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupCellInterface];
    }
    
    return self;
}

- (void)setupCellInterface
{
    UIImageView *iconV = [[UIImageView alloc] init];
    [self.contentView addSubview:iconV];
    self.iconV = iconV;
    
    UILabel *titleL = [[UILabel alloc] init];
    [self.contentView addSubview:titleL];
    self.titleL = titleL;
    titleL.textAlignment = 0;
    titleL.font = [UIFont systemFontOfSize:15 *kScale];
    
    UILabel *detailL = [[UILabel alloc] init];
    [self.contentView addSubview:detailL];
    self.detailL = detailL;
    detailL.textAlignment = 2;
    detailL.font = [UIFont systemFontOfSize:15 *kScale];
    detailL.textColor = [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1.0];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.iconV.frame = CGRectMake(15 *kScale, 0, 30 *kScale, 30 *kScale);
    self.iconV.centerY = self.contentView.centerY;
    
    self.titleL.frame = CGRectMake(CGRectGetMaxX(self.iconV.frame) +15 *kScale, 0, 60 *kScale, 30 *kScale);
    self.titleL.centerY = self.contentView.centerY;
    
    self.detailL.frame = CGRectMake(self.contentView.width - 160 *kScale, 0, 140 *kScale, 30 *kScale);
    self.detailL.centerY = self.contentView.centerY;
}

- (void)setDict:(NSDictionary *)dict
{
    self.iconV.image = [UIImage imageNamed:dict[@"icon"]];
    self.titleL.text = dict[@"title"];
    self.detailL.text = dict[@"money"];
}
- (void)setBillModel:(QZBillModel *)billModel
{
    self.iconV.image = [UIImage imageNamed:billModel.item];
    self.titleL.text = billModel.item;
    NSString *money;
    if ([billModel.type integerValue] == 1) {
        // 收入
        money = [NSString stringWithFormat:@"+%@", billModel.money];
    } else {
        // 支出
        money = [NSString stringWithFormat:@"-%@", billModel.money];
    }
    self.detailL.text = money;
}
@end
