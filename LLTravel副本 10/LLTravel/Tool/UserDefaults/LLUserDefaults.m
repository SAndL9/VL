//
//  LLUserDefaults.m
//  LLTravel
//
//  Created by lanouhn on 16/6/1.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLUserDefaults.h"
//存储次数
#define kLaunch_Time @"launch_times"

#define kLogin_Data @"user_data"
static LLLoginDataModel *model = nil;



@implementation LLUserDefaults
//初始化方法存储类
+(void)initDefaults{
    if ([LLUserDefaults getLaunchTimes] == nil) {
        //设置g当第一次启动的时候 默认是1
        //注册  避免使用setValue forkey  杂乱五章
        NSDictionary *dic = [NSDictionary dictionaryWithObject:@"1" forKey:kLaunch_Time];
        [[NSUserDefaults standardUserDefaults] registerDefaults:dic];
    }
}

//存储当前用户启动的次数
+(void)setLaunchTimes:(NSString*)launchtimes{
    [[NSUserDefaults standardUserDefaults] setValue:launchtimes forKey:kLaunch_Time];
}
//获得启动的次数
+(NSString*)getLaunchTimes{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kLaunch_Time];
}




//------由于model继承之Nsobject,存入的时候需要转成归档对象后的data--------------------------
//保存用户信息
+(void)saveUserInfo:(LLLoginDataModel*)model{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //将model数据转成NSData
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [userDefault setObject:data forKey:kLogin_Data];
    
    //NSUserDefault 不是立即写入内存 我们需要手动同步一下 
    [userDefault synchronize];
}
//获取用户信息
+(LLLoginDataModel*)getUserInfo{
    if (model == nil) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSData *data = [userDefault objectForKey:kLogin_Data];
        if (data) {
            model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }else{
            return nil;
        }
    }
    return model;
}

//判断用户是否登录
+(BOOL)isLogin{
    if ( [LLUserDefaults getUserInfo] == nil) {
        return NO;
    }
        return YES;
   
}
//清除用户信息登录
-(void)clearUserData{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLogin_Data];
    [[NSUserDefaults standardUserDefaults]synchronize];
    model = nil;
}

@end
