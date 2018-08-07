//
//  BaseNetService.m
//  jizhang
//
//  Created by Adam on 2018/8/6.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "BaseNetService.h"
#import <AFNetworking.h>

@implementation BaseNetService

+ (instancetype)sharedManager
{
    static BaseNetService *service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [BaseNetService new];
    });
    return service;
}

- (void)POST:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    [manage POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"网络请求========url:%@\n%@",task.response.URL,responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络请求error========url:%@\n%@",task.response.URL,error);
        failure(error);
    }];
}
@end
