//
//  LLDetailTravelSectionHeaderView.h
//  LLTravel
//
//  Created by lanouhn on 16/6/12.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLDetailTravelSectionHeaderViewDelegate <NSObject>

//设置代理方法 传递button的tag值
-(void)buttonClick:(NSInteger)tag;

@end

@interface LLDetailTravelSectionHeaderView : UIView

//设置代理属性
@property(nonatomic,assign)id <LLDetailTravelSectionHeaderViewDelegate>delegate;
//初始化方法
-(instancetype)initWithFrame:(CGRect)frame;

@end
