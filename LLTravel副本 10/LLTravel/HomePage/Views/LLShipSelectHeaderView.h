//
//  LLShipSelectHeaderView.h
//  LLTravel
//
//  Created by lanouhn on 16/6/12.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLShipSelectHeaderView : UIView

//button的点击回调---当前点击的是index
@property(nonatomic,copy)void(^buttonClick)(NSInteger index);


//重写
-(instancetype)initWithFrame:(CGRect)frame;

@end
