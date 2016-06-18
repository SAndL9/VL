//
//  LLPeripheralFeatureSpotView.m
//  LLTravel
//
//  Created by lanouhn on 16/6/2.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLPeripheralFeatureSpotView.h"

#import "UIButton+WebCache.h"
@interface LLPeripheralFeatureSpotView ()

@property (weak, nonatomic) IBOutlet UIButton *leftTopButton;

@property (weak, nonatomic) IBOutlet UIButton *rightTopButton;

@property (weak, nonatomic) IBOutlet UIButton *leftBottomButton;

@property (weak, nonatomic) IBOutlet UIButton *rightBottomButton;

@property (weak, nonatomic) IBOutlet UIButton *StewardButton;
@end

@implementation LLPeripheralFeatureSpotView

//刷新数据源
-(void)UpDataButtonArray:(NSMutableArray*)array{
    _perArray  = array;
    LLPeripheraModel *model = [[LLPeripheraModel alloc]init];
    model = [_perArray objectAtIndex:0];
    [self.leftTopButton  setTitle:model.title forState:UIControlStateNormal];
    [self.leftTopButton sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_Base,model.src]] forState:UIControlStateNormal];
    
    model = [_perArray objectAtIndex:1];
    [self.rightTopButton  setTitle:model.title forState:UIControlStateNormal];
    [self.rightTopButton sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_Base,model.src]] forState:UIControlStateNormal];
    
    model = [_perArray objectAtIndex:2];
    [self.leftBottomButton  setTitle:model.title forState:UIControlStateNormal];
    [self.leftBottomButton sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_Base,model.src]] forState:UIControlStateNormal];
    
    model = [_perArray objectAtIndex:3];
    [self.rightBottomButton  setTitle:model.title forState:UIControlStateNormal];
    NSString *str =[NSString stringWithFormat:@"%@%@",URL_Base,model.src];
    NSLog(@"%@",str);
    [self.rightBottomButton sd_setBackgroundImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal];
    NSLog(@"modelsrc======= %@",model.src);
    
    
}
//初始化方法
//声明初始化周边景点视图
-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray*)dataArray{
    if (self = [super initWithFrame:frame]) {
        //
        NSArray *viewArray = [[NSBundle mainBundle]loadNibNamed:@"LLPeripheralFeatureSpotView" owner:self options:nil];
        self = viewArray[0];
        self.frame = frame;
        
        //给当前的周边景点和按钮和管家按钮赋值
//        [self.leftTopButton setTitle:@"少林寺" forState:UIControlStateNormal];
        [self.StewardButton setBackgroundImage:[UIImage imageNamed:@"home_assisant_ad@2x"] forState:UIControlStateNormal];
        
    }
    return self;
}





#pragma mark   4个button点击事件
//button 点击事件----点击周边景点按钮时，回调点击的button的index
- (IBAction)clickedTheButton:(UIButton *)sender {
    
    self.peripheralButtonClicker(sender.tag);
//    NSLog(@"旅游景点被点击了。。。。");
    
}
//管家点击按钮  回调关键按钮的标识

- (IBAction)clickedTheStewardButton:(UIButton *)sender {
    self.stewardButtonClicked(sender.tag);
//    NSLog(@"管家被点击了.....");
}

//更多按钮点击 回调出去....
- (IBAction)moreButtonClicked:(UIButton *)sender {
    self.moreButtonClicker(sender.tag);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
