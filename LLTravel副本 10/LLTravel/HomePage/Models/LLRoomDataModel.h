//
//  LLRoomDataModel.h
//  LLTravel
//
//  Created by lanouhn on 16/6/12.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLBaseModel.h"

@interface LLRoomDataModel : LLBaseModel
/**
 *  c_id: "83717",
 product_id: "53927",
 cabin_thumb: "/upload/album/201601/098ae07c1ae8d1bb1a3172828a3e2bf7.jpg",
 type_name: "内舱房",
 window: "2",
 type_id: "1",
 first_price: "30880.00",
 second_price: "25880.00",
 third_price: "23880.00",
 rebate: "200.00",
 sell: "2",
 stock: "12",
 cabin_id: "741",
 cabin_name: "标准内舱房",
 size: "11",
 num: "4",
 floors: "2-5",
 profile: "<p>浴室（配淋浴）、梳妆台、电视、保险箱、吹风机</p><p><br/></p>",
 first_price_basic: "28880.00",
 second_price_basic: "23880.00",
 third_price_basic: "21880.00"
 */
@property(nonatomic,copy)NSString *c_id;
@property(nonatomic,copy)NSString *product_id;
@property(nonatomic,copy)NSString *cabin_thumb;
@property(nonatomic,copy)NSString *type_name;
@property(nonatomic,copy)NSString *window;
@property(nonatomic,copy)NSString *type_id;
@property(nonatomic,copy)NSString *first_price;
@property(nonatomic,copy)NSString *second_price;
@property(nonatomic,copy)NSString *third_price;
@property(nonatomic,copy)NSString *rebate;
@property(nonatomic,copy)NSString *sell;
@property(nonatomic,copy)NSString *stock;
@property(nonatomic,copy)NSString *cabin_id;
@property(nonatomic,copy)NSString *cabin_name;
@property(nonatomic,copy)NSString *size;
@property(nonatomic,copy)NSString *num;
@property(nonatomic,copy)NSString *floors;
@property(nonatomic,copy)NSString *profile;
@property(nonatomic,copy)NSString *first_price_basic;
@property(nonatomic,copy)NSString *second_price_basic;
@property(nonatomic,copy)NSString *third_price_basic;

//-----------------
//添加成人数目
@property(nonatomic,copy)NSString *adultNumStr;
//添加儿童数目
@property(nonatomic,copy)NSString *childNumStr;


@end
