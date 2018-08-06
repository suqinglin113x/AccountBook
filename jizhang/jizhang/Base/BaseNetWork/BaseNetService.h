//
//  BaseNetService.h
//  jizhang
//
//  Created by Adam on 2018/8/6.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseNetService : NSObject

+ (instancetype)sharedManager;

- (void)POST:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void(^)(NSError *error))failure;


@end
