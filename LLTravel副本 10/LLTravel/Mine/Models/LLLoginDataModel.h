//
//  LLLoginDataModel.h
//  LLTravel
//
//  Created by lanouhn on 16/6/17.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLBaseModel.h"

@interface LLLoginDataModel : LLBaseModel <NSCopying>

@property(nonatomic,copy)NSString *address;//地址
@property(nonatomic,copy)NSString *auto_token;//
@property(nonatomic,copy)NSString *avater; //头像
@property(nonatomic,copy)NSString *birthday; //生日
@property(nonatomic,copy)NSString *sex; //性别
@property(nonatomic,copy)NSString *city;//城市
@property(nonatomic,copy)NSString *phone; //电话
@property(nonatomic,copy)NSString *uid; //id标识
@property(nonatomic,copy)NSString *username;//用户名
@property(nonatomic,copy)NSString *realname;//姓名
@property(nonatomic,copy)NSString *wx_name;//第三方登录的名字
@property(nonatomic,copy)NSString *email;//邮箱
@property(nonatomic,copy)NSString *idnumber;//证件照

@end
