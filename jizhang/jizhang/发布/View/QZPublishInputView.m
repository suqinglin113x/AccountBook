//
//  QZPublishInputView.m
//  jizhang
//
//  Created by 邓振娜 on 2018/8/6.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZPublishInputView.h"
#import "QZPublishInputCollectionCell.h"

#define kTextColor       [UIColor colorWithR:51 g:51 b:51]

static NSString * collectionCellIdentifier = @"publishCollectionCellIdentifier";
static NSString * collectionHeaderIdentifier = @"publishCollectionHeaderIdentifier";
static NSString * collectionFooterIdentifier = @"publishCollectionFooterIdentifier";

@interface QZPublishInputView ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *choiceLbl;
@property (nonatomic, strong) UITextField *inputField;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation QZPublishInputView

- (UIImageView *)iconView {
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"icon_吃喝"];
    }
    return _iconView;
}

- (UILabel *)choiceLbl {
    if (_choiceLbl == nil) {
        _choiceLbl = [QZWidgetTool creatLabelWithText:@"吃喝" font:16 color:kTextColor alignment:NSTextAlignmentLeft];
    }
    return _choiceLbl;
}

- (UITextField *)inputField {
    if (_inputField == nil) {
        _inputField = [[UITextField alloc] init];
        _inputField.placeholder = @"¥0.00";
        _inputField.textAlignment = NSTextAlignmentRight;
        _inputField.font = kNAFont(27);
        _inputField.textColor = kTextColor;
        _inputField.keyboardType = UIKeyboardTypeDecimalPad;
        _inputField.returnKeyType = UIReturnKeyDone;
        _inputField.borderStyle = UITextBorderStyleNone;
        _inputField.delegate = self;
    }
    return _inputField;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;//每个section中的行和行之间的间距
        layout.minimumInteritemSpacing = 0;//每个section中列和列之间的间距

        layout.itemSize = CGSizeMake(kScreenWidth*0.25, kScreenWidth*0.25);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarAndStatusBarHeight-60*kScale) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = kBgColor;
        _collectionView.pagingEnabled = YES;
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        //注册
        [_collectionView registerClass:[QZPublishInputCollectionCell class] forCellWithReuseIdentifier:collectionCellIdentifier];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeaderIdentifier];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:collectionFooterIdentifier];
    }
    return _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.collectionView];
        
        [self addSubview:self.iconView];
        [self addSubview:self.choiceLbl];
        [self addSubview:self.inputField];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(self).offset(61 * kScale);
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(13*kScale);
        make.left.equalTo(self).offset(25*kScale);
        make.width.height.mas_equalTo(35*kScale);
    }];
    
    [self.choiceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(10*kScale);
        make.centerY.equalTo(self.iconView);
        make.width.height.mas_equalTo(40 * kScale);
    }];
    
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-25*kScale);
        make.top.equalTo(self);
        make.left.equalTo(self.choiceLbl.mas_right);
        make.bottom.equalTo(self.collectionView.mas_top);
    }];
}

- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    
    NSString *imgName = [NSString stringWithFormat:@"icon_%@",self.dataArr[0]];
    self.iconView.image = [UIImage imageNamed:imgName];
    self.choiceLbl.text = self.dataArr[0];
    
    [self.collectionView reloadData];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QZPublishInputCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellIdentifier forIndexPath:indexPath];
    
    NSString *imgName = [NSString stringWithFormat:@"icon_%@",self.dataArr[indexPath.item]];
    cell.iconView.image = [UIImage imageNamed:imgName];
    cell.titleLbl.text = self.dataArr[indexPath.item];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeaderIdentifier forIndexPath:indexPath];
        view.backgroundColor = [UIColor blueColor];
        return view;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:collectionFooterIdentifier forIndexPath:indexPath];
        view.backgroundColor = [UIColor greenColor];
        return view;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSString *imgName = [NSString stringWithFormat:@"icon_%@",self.dataArr[indexPath.item]];
    self.iconView.image = [UIImage imageNamed:imgName];
    self.choiceLbl.text = self.dataArr[indexPath.item];
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // 当前输入的字符是'.'
    if ([string isEqualToString:@"."]) {
        // 已输入的字符串中已经包含了'.'或者""
        if ([textField.text rangeOfString:@"."].location != NSNotFound || [textField.text isEqualToString:@""]) {
            return NO;
        }else if (textField.text.length >= 12) {
            return NO;
        } else {
            return YES;
        }
    } else {// 当前输入的不是'.'
        // 第一个字符是0时, 第二个不能再输入0
        if (textField.text.length == 1) {
            unichar str = [textField.text characterAtIndex:0];
            if (str == '0' && [string isEqualToString:@"0"]) {
                return NO;
            }
            if (str != '0' && str != '1') {// 1xx或0xx
                return YES;
            } else {
                if (str == '1') {
                    return YES;
                } else {
                    if ([string isEqualToString:@""]) {
                        return YES;
                    } else {
                        return NO;
                    }
                }
                
            }
        }
        
        // 已输入的字符串中包含'.'
        if ([textField.text rangeOfString:@"."].location != NSNotFound) {
            NSMutableString *str = [[NSMutableString alloc] initWithString:textField.text];
            [str insertString:string atIndex:range.location];
            if (str.length >= [str rangeOfString:@"."].location + 4) {
                return NO;
            }
            NSLog(@"str.length = %ld, str = %@, string.location = %ld", str.length, string, range.location);
        } else {
            if (textField.text.length > 11) {
                if ([string isEqualToString:@""]) {
                    return YES;
                }
                return textField.text.length < 12;
            }
        }
        
    }
    
    return YES;
}

- (void)fieldResignFirstResponder {
    [self.inputField resignFirstResponder];
}

- (NSDictionary *)getChoiceItem {
    NSDictionary *dic = @{@"item":self.choiceLbl.text,@"money":self.inputField.text};
    return dic;
}

@end
