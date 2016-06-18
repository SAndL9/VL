//
//  LLNetWorkManage.m
//  LLTravel
//
//  Created by lanouhn on 16/6/1.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLNetWorkManage.h"
#import <AFNetworking/AFNetworking.h>
@implementation LLNetWorkManage
//单例
/**
 *  封装GET请求
 *
 *  @param urlStr   网络请求的URL
 *  @param paramDic 请求参数
 *  @param finsh    回调指网络请求成功回调
 *  @param enError  表示失败回调
 */
+(void)requestGetWithUrlStr:( NSString*)urlStr paramDict:(NSDictionary*)paramDic finish:(void(^)(id responseObejct))finsh enError:(void(^)(NSError *error))enError{
    
    //创建一个sessionManage对象
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    //指定我们能够解析的数据 包含xml
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    [manage GET:urlStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finsh(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
#warning  AFNetWorking请求结果回调的时候，failure方法会在两种情况下回调：1.请求服务器失败，服务器返回失败信息 2.服务器返回数据成功 AFN解析数据失败.   //当请求失败的时候 或者 请求成功返回的数据是错误的
        enError(error);
    }];
    
}

/**
 *  封装Post请求
 *
 *  @param urlStr   网络请求
 *  @param paramDic 参数
 *  @param finsh    成功回调
 *  @param enError  错误回调
 */
+(void)requestPOSTWithUrlStr:(NSString *)urlStr paramDict:(NSDictionary *)paramDic finish:(void (^)(id responseObject))finsh enError:(void (^)(NSError *error))enError{
    //创建seccsionmanage对象
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    //指定我们能够解析的数据 包含xml
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    [manage POST:urlStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finsh(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        enError(error);
    }];
    
    
}

@end
