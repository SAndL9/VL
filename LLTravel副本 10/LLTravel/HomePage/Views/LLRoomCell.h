//
//  LLRoomCell.h
//  LLTravel
//
//  Created by lanouhn on 16/6/12.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLRoomDataModel.h"

@interface LLRoomCell : UITableViewCell

@property(nonatomic,copy)void (^buttonClicked)(NSString *room_id);//声明变量block传递点击的相应预定房间的id

//给cell 赋值
-(void)setCellDataWith:(LLRoomDataModel*)data;

@end
