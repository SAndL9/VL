//
//  LLRouteDateCell.h
//  LLTravel
//
//  Created by lanouhn on 16/6/13.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLDaysModel.h"
@interface LLRouteDateCell : UITableViewCell

//给cell赋值
-(void)setCellDataWith:(LLDaysModel*)model;

@end
