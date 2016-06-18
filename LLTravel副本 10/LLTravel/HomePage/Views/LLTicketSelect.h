//
//  LLTicketSelect.h
//  LLTravel
//
//  Created by lanouhn on 16/6/18.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLTicketSelect : UIView
//button的点击回调---当前点击的是index
@property(nonatomic,copy)void(^buttonClick)(NSInteger index);
@end
