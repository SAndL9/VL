//
//  LLRouteDetailHeaderView.h
//  LLTravel
//
//  Created by lanouhn on 16/6/13.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLRouteDetailHeaderView : UITableViewHeaderFooterView
//右面第一个
@property (weak, nonatomic) IBOutlet UILabel *rightDayLab;
//路程详情
@property (weak, nonatomic) IBOutlet UILabel *RouteLab;

@end
