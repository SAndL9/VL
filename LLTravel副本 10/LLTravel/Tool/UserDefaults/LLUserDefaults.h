//
//  LLUserDefaults.h
//  LLTravel
//
//  Created by lanouhn on 16/6/1.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLLoginDataModel.h"
@interface LLUserDefaults : NSObject

//初始化方法存储类
+(void)initDefaults;


//存储当前用户启动的次数
+(void)setLaunchTimes:(NSString*)launchtimes;
+(NSString*)getLaunchTimes;
//--------------------------------
//保存用户信息
+(void)saveUserInfo:(LLLoginDataModel*)model;
//获取用户信息
+(LLLoginDataModel*)getUserInfo;

//判断用户是否登录
+(BOOL)isLogin;
//清除用户信息登录
-(void)clearUserData;


@end
