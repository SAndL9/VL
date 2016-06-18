//
//  LLNetWorkManage.h
//  LLTravel
//
//  Created by lanouhn on 16/6/1.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
//typedef void(^RequestBlock)();
@interface LLNetWorkManage : NSObject


//单例
/**
 *  封装GET请求
 *
 *  @param urlStr   网络请求的URL
 *  @param paramDic 请求参数
 *  @param finsh    回调指网络请求成功回调
 *  @param enError  表示失败回调
 */
+(void)requestGetWithUrlStr:( NSString*)urlStr paramDict:(NSDictionary*)paramDic finish:(void(^)(id responseObejct))finsh enError:(void(^)(NSError *error))enError;

/**
 *  封装Post请求
 *
 *  @param urlStr   网络请求
 *  @param paramDic 参数
 *  @param finsh    成功回调
 *  @param enError  错误回调
 */
+(void)requestPOSTWithUrlStr:(NSString *)urlStr paramDict:(NSDictionary *)paramDic finish:(void (^)(id responseObject))finsh enError:(void (^)(NSError * error))enError;



@end
