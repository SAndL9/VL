//
//  LLRoomTypePriceBtn.h
//  LLTravel
//
//  Created by lanouhn on 16/6/15.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLRoomTypePriceBtn : UIButton
@property (weak, nonatomic) IBOutlet UIView *lineView;



//初始化button时 传递房间类型参数和价格参数
-(instancetype)initWithFrame:(CGRect)frame roomType:(NSString *)roomtype price:(NSString*)price;
//改变颜色
-(void)changeColorWith:(UIColor *)color;
@end
