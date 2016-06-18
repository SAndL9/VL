//
//  LLDaysModel.h
//  LLTravel
//
//  Created by lanouhn on 16/6/12.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLBaseModel.h"

@interface LLDaysModel : LLBaseModel
/**
 *  schedule_id: "80831",
 arrival_time: " ",
 sail_time: " ",
 title: "广州/香港-巴塞罗那 ",
 schedule_type: "2",
 breakfast: "0",
 lunch: "0",
 dinner: "0",
 detail: "于指定日期及时间在广州或香港国际机场集合搭乘国际航机前往西班牙巴塞罗那॰",
 album: [],
 type: "其他",
 day: "1",
 destination: "巴塞罗那",
 tour_list: [
 */

@property(nonatomic,copy)NSString *schedule_id;
@property(nonatomic,copy)NSString *arrival_time;
@property(nonatomic,copy)NSString *sail_time;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *schedule_type;
@property(nonatomic,copy)NSString *breakfast;
@property(nonatomic,copy)NSString *lunch;
@property(nonatomic,copy)NSString *dinner;
@property(nonatomic,copy)NSString *detail;
@property(nonatomic,strong)NSMutableArray *album;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *day;
@property(nonatomic,copy)NSString *destination;
@property(nonatomic,strong)NSMutableArray *tour_list;



@end
