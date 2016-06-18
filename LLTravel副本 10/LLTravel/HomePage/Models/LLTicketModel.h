//
//  LLTicketModel.h
//  LLTravel
//
//  Created by lanouhn on 16/6/6.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLBaseModel.h"

@interface LLTicketModel : LLBaseModel
@property(nonatomic,copy)NSString *scenic_name;//名字
@property(nonatomic,copy)NSString *image;//图片
@property(nonatomic,copy)NSString *start_price;//钱
@property(nonatomic,copy)NSString *place_level;//景区级别


@property(nonatomic,copy)NSString *placeToAddr;//地址


@property(nonatomic,copy)NSString *openTime;//开放时间


@property(nonatomic,copy)NSString *freePolicy;//优惠人群
@property(nonatomic,copy)NSString *explanation;//说明
@property(nonatomic,copy)NSString *offerCrowd;//优惠政策
@property(nonatomic,copy)NSString *product_reminder;//温馨提示


@property(nonatomic,copy)NSMutableArray *playAttraction;//数组存放里面的显示


@end
