//
//  LLSectionHeaderView.h
//  LLTravel
//
//  Created by lanouhn on 16/6/3.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class LLSectionHeaderView;
@protocol  LLSectionHeaderViewDelegate <NSObject>
//设置代理方法  传递button的tag值
-(void)buttonClik:(NSInteger)tag;

@end



@interface LLSectionHeaderView : UIView
//设置代理属性
@property(nonatomic,weak)id<LLSectionHeaderViewDelegate>delegate;

//初始化方法
-(instancetype)initWithFrame:(CGRect)frame;

@end
