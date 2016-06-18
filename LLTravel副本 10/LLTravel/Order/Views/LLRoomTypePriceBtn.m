//
//  LLRoomTypePriceBtn.m
//  LLTravel
//
//  Created by lanouhn on 16/6/15.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLRoomTypePriceBtn.h"

@interface LLRoomTypePriceBtn ()
@property (weak, nonatomic) IBOutlet UILabel *roomTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

@end


@implementation LLRoomTypePriceBtn

//初始化button时 传递房间类型参数和价格参数
-(instancetype)initWithFrame:(CGRect)frame roomType:(NSString *)roomtype price:(NSString*)price{
    if (self = [super initWithFrame:frame]) {
        NSArray *viewArray = [[NSBundle mainBundle] loadNibNamed:@"LLRoomTypePriceBtn" owner:self options:nil];
        self = viewArray[0];
        self.frame =frame;
        
        self.roomTypeLab.text = roomtype;
        self.priceLab.text = price;
    }
    return self;
}
//改变颜色 -----选中的时候 改变颜色
-(void)changeColorWith:(UIColor *)color{
    self.roomTypeLab.textColor = color;
    self.priceLab.textColor = color;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
