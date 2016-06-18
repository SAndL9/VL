//
//  LLShipModel.h
//  LLTravel
//
//  Created by lanouhn on 16/6/6.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLBaseModel.h"

@interface LLShipModel : LLBaseModel

@property(nonatomic,copy)NSString *thumb;//照片
@property(nonatomic,copy)NSString *product_name;//名字
@property(nonatomic,copy)NSString *min_price;//价格
@property(nonatomic,copy)NSString *port_name;//从哪个城市出发
@property(nonatomic,copy)NSString *product_id;//id标识

@end
