//
//  LLTicketHeadView.m
//  LLTravel
//
//  Created by lanouhn on 16/6/15.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLTicketHeadView.h"

@implementation LLTicketHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSArray *ViewArray = [[NSBundle mainBundle]loadNibNamed:@"LLTicketHeadView" owner:self options:nil];
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
