//
//  LLRoominfoView.m
//  LLTravel
//
//  Created by lanouhn on 16/6/17.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLRoominfoView.h"
#import "UIImageView+WebCache.h"

@implementation LLRoominfoView
//给view上赋值

//初始化方法
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSArray *ViewArray = [[NSBundle mainBundle]loadNibNamed:@"LLRoominfoView" owner:self options:nil];
        self = ViewArray[0];
        self.frame =frame;
    }
    return self;
}
//更新数据
-(void)updateDataWith:(LLRoomDataModel*)model{
    //不隐藏视图
    self.hidden = NO;
    self.roomTypeLab.text = model.cabin_name;
    //获得图片路径
    NSString *picStr = [NSString stringWithFormat:@"%@%@",URL_Base,model.cabin_thumb];
    [self.roomImageView sd_setImageWithURL:[NSURL URLWithString:picStr] placeholderImage:[UIImage imageNamed:@"6"]];
    self.areaLab.text = [NSString stringWithFormat:@"%@㎡",model.size];
    self.numLab.text = model.num;
    self.floorLab.text = model.floors;
}

//添加手势 ---隐藏视图
- (IBAction)tapTheRoomViewAction:(UITapGestureRecognizer *)sender {
    if (!self.hidden) {
        self.hidden = YES;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
