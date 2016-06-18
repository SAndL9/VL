//
//  LLTravelDestinationView.m
//  LLTravel
//
//  Created by lanouhn on 16/6/3.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLTravelDestinationView.h"
#import "LLPeripheraModel.h"
#import "UIButton+WebCache.h"
@implementation LLTravelDestinationView


//点击 更多按钮 实现 协议 回调
- (IBAction)clickedTheMoreButton:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(moreButtonClicked)]) {
        [self.delegate moreButtonClicked];
    }
}
//点击旅游景点 实现协议回调
- (IBAction)clickedTheSightSpotButton:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sightSpotButtonClicked)]) {
        [self.delegate sightSpotButtonClicked];
    }
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
//刷新数据源
-(void)UpDataButtonArray:(NSMutableArray*)array{
    self.dataArray = array;
    LLPeripheraModel *model = [[LLPeripheraModel alloc]init];
    model = [self.dataArray objectAtIndex:0];
    NSLog(@"########%@",model);

  
    [self.sightSoptButton  sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_Base,model.src]] forState:UIControlStateNormal];
    [self.sightSoptButton setTitle:model.title forState:UIControlStateNormal];
    
}

//声明一个初始化方法
-(instancetype)initWithFrame:(CGRect)frame withDataDic:(NSDictionary*)dataDictionary{
    if (self = [super initWithFrame:frame]) {
        NSArray *ViewArray = [[NSBundle   mainBundle]loadNibNamed:@"LLTravelDestinationView" owner:self options:nil];
        self = [ViewArray objectAtIndex:0];
        self.frame = frame;
        
        //设置corver的边框宽度
        //设置边框是否可以切割
        self.corverLabel.layer.masksToBounds = YES;
        //设置边框颜色
        self.corverLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        //设置边框的宽度
        self.corverLabel.layer.borderWidth = 3;
        
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
