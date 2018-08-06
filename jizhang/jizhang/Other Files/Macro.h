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
#endif /* Macro_h */
