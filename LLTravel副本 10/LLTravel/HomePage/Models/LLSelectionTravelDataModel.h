//
//  LLSelectionTravelDataModel.h
//  LLTravel
//
//  Created by lanouhn on 16/6/7.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLBaseModel.h"

@interface LLSelectionTravelDataModel : LLBaseModel
//航线模型
@property(nonatomic,copy)NSString *product_name;//名字
@property(nonatomic,copy)NSString *min_price;//价格
@property(nonatomic,copy)NSString *product_id;//标识id
@property(nonatomic,copy)NSString *port_name;//出发地
@property(nonatomic,copy)NSString *thumb;//图片
@end
