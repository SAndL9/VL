//
//  CalendarCellModel.h
//  VTravel
//
//  Created by zhangmeng on 16/6/12.
//  Copyright © 2016年 Lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarCellModel : NSObject
@property (nonatomic, copy) NSString * dateStr; //当前item对应的时间
@property (nonatomic, assign) BOOL isSign; //是否标记
@end
