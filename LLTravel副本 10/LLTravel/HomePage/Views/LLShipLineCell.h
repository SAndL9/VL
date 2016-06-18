//
//  LLShipLineCell.h
//  LLTravel
//
//  Created by lanouhn on 16/6/8.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLSelectionTravelDataModel.h"
@interface LLShipLineCell : UITableViewCell





//给cell赋值  model 参数为cell要展示的数据
-(void)setCellDataModel:(LLSelectionTravelDataModel*)model;

@end
