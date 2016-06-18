//
//  StewardListCell.h
//  VTravel-0601
//
//  Created by lanouhn on 16/6/6.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLStewardListModel.h"
@interface StewardListCell : UITableViewCell



//配置cell的数据 根据传递的数据 给cell赋值
-(void)setupDataWith:(LLStewardListModel*)model;


@end
