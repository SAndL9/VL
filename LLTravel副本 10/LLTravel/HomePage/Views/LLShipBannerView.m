//
//  LLShipBannerView.m
//  LLTravel
//
//  Created by lanouhn on 16/6/8.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLShipBannerView.h"

@implementation LLShipBannerView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSArray *ViewArray = [[NSBundle mainBundle]loadNibNamed:@"LLShipBannerView" owner:self options:nil];
        self = ViewArray[0];
        self.frame = frame; 
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
