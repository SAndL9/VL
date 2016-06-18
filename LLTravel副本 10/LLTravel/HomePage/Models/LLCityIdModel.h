//
//  LLCityIdModel.h
//  LLTravel
//
//  Created by lanouhn on 16/6/14.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLBaseModel.h"

@interface LLCityIdModel : LLBaseModel

@property(nonatomic,copy)NSString *region_id;
@property(nonatomic,copy)NSString *parent_id;
@property(nonatomic,copy)NSString *region_name;
@property(nonatomic,copy)NSString *region_type;
//@property(nonatomic,copy)NSString *prefix;
@property(nonatomic,copy)NSString *is_open;

@property(nonatomic,copy)NSString *cityFirst;

@end
