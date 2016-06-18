//
//  LLStewardListModel.h
//  LLTravel
//
//  Created by lanouhn on 16/6/6.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLBaseModel.h"

@interface LLStewardListModel : LLBaseModel
@property(nonatomic,copy)NSString *avatar; //头像
@property(nonatomic,copy)NSString *name; //名字
@property(nonatomic,copy)NSString *order_count; //案例数
@property(nonatomic,copy)NSString *level; //评分
@property(nonatomic,copy)NSString *advantage; //
@property(nonatomic,copy)NSString *assistant_id;//管家id  用于跳转到管家详情传递的参数
//年龄，性别，星座，
@property(nonatomic,copy)NSString *birth_date;//出生日期
@property(nonatomic,copy)NSString *gender;//性别
@property(nonatomic,copy)NSString *horoscope;//星座
@end
