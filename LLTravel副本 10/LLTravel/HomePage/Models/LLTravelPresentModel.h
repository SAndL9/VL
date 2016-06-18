//
//  LLTravelPresentModel.h
//  LLTravel
//
//  Created by lanouhn on 16/6/13.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLBaseModel.h"

@interface LLTravelPresentModel : LLBaseModel

@property(nonatomic,copy)NSString *product_name;//名字
@property(nonatomic,copy)NSString *product_id;//标识id
@property(nonatomic,copy)NSString *thumb;//图片
@property(nonatomic,copy)NSString *city_id;//城市id
@property(nonatomic,copy)NSString *adult_price;//价格

@end
