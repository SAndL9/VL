//
//  LLDetailTravelViewModel.h
//  LLTravel
//
//  Created by lanouhn on 16/6/8.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLBaseModel.h"

@interface LLDetailTravelViewModel : LLBaseModel
@property(nonatomic,copy)NSString *product_id; //标识id
@property(nonatomic,copy)NSString *product_name;//名字
@property(nonatomic,copy)NSString *thumb;//图片地址
@property(nonatomic,copy)NSString *adult_price;
@property(nonatomic,copy)NSString *date_time; //跟团时间
@property(nonatomic,copy)NSString *tag_name; //旅游类型

@property(nonatomic,copy)NSString *_goto; //
@end
