//
//  Macro.h
//  jizhang
//
//  Created by Adam on 2018/8/1.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScale [[UIScreen mainScreen] bounds].size.width/375


#define UIColorFromHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define kMainColor      [UIColor colorWithR:255 g:222 b:1]
#define kBgColor      [UIColor colorWithR:248 g:248 b:248]
#define kLineColor           [UIColor colorWithR:128 g:128 b:128]
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeigth 44
#define kNavBarAndStatusBarHeight (kStatusBarHeight + kNavBarHeigth)
#define kTabBarHeight (kScreenHeight == 812 ? 83 : 49)
#define kNAFont(size)      [UIFont systemFontOfSize:size * kScale]
#define kScaleY [[UIScreen mainScreen] bounds].size.width/667
//log
#ifndef __OPTIMIZE__
#define NALog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NALog(...){}
#endif

#define kNetError @"网络请求错误,请稍后再试"
#define kNoData @"无记账记录"

#define USERID_KEY @"userId"


#endif /* Macro_h */
