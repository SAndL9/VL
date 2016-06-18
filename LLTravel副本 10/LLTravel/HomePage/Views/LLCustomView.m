//
//  LLCustomView.m
//  LLTravel
//
//  Created by lanouhn on 16/6/2.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLCustomView.h"
#import "LLCustomButton.h"
#import "LLLineDataModel.h"

#define kWidth (frame.size.width - kSpacing * 5) / 4
#define kSpacing 30  //间隔-间距

@implementation LLCustomView

//声明自定义的滚动视图  传入动态要显示的button文字和 Image
-(instancetype)initWithFrame:(CGRect)frame WithTitleArray:(NSArray*)titleArray imageArray:(NSArray*)imageArray{
    
    if (self = [super initWithFrame:frame]) {
        //view背景色
        self.backgroundColor = [UIColor whiteColor];
        //根据传进来的数据 计算scrollview的页数 个数
        NSInteger pageNum = titleArray.count / 4 < titleArray.count / 4.0 ? (titleArray.count / 4 + 1) : titleArray.count / 4;
        //创建显示可根据button的个数来显示可滚动的scrollview
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        //设置scrollview的课滚动的范围
        scrollView.contentSize = CGSizeMake(pageNum *size_width, frame.size.height);
        //设置整页滚动
        scrollView.pagingEnabled = YES;
        //隐藏下面的条
        scrollView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:scrollView];
        
        
      //--------------添加button---------------
        //在scrollview 上添加button  设置button之间的间距为30 距离屏幕为30
        //表示第几页
        NSInteger page = 0;
        
        for (int  i = 0; i <titleArray.count; i++) {
            //计算当前是第几页
            page = i / 4 + 1;
            //表示当前button是第几页  (frame.size.width - kSpacing * 5) / 4 表示button在scrollview显示为每页4个 并且button的间距为30
            CGFloat button_X = ((frame.size.width - kSpacing * 5) / 4 + kSpacing) * i +kSpacing * page;
            
            //创建button
            LLCustomButton *button = [[LLCustomButton alloc]initWithFrame:CGRectMake(button_X, 15, kWidth, frame.size.height - 15) title:titleArray[i] imageName:imageArray[i]];
            //设置button的tag值 来作为button被点击时的坐标
            button.tag = 1000 + i ;
            //添加到scrollview 上
            [scrollView addSubview:button];
            //给button添加点击事件
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}
//button的点击事件 ---- 通过button的回调 来实现点击操作.
-(void)buttonClicked:(UIButton*)sender{
    NSInteger tag = sender.tag;
    //传递 button的
    self.buttonClick(tag);
    //打印点击的是哪个button
//    NSLog(@"tag-- %ld text-- %@",sender.tag,sender.titleLabel);
    
}



#pragma mark ------2级页面------
//初始化邮轮界面的航线模块
-(instancetype)initWithFrame:(CGRect)frame WithDataArray:(NSArray*)dataArray{
    //获得航线的个数
    NSInteger count = dataArray.count;

    if (self = [super initWithFrame:frame]) {
        //view背景色
        self.backgroundColor = [UIColor whiteColor];
        //根据传进来的数据 计算scrollview的页数 个数
        NSInteger pageNum = count / 4 < count / 4.0 ? (count / 4 + 1) : count / 4;
        //创建显示可根据button的个数来显示可滚动的scrollview
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        //设置scrollview的可滚动的范围
        scrollView.contentSize = CGSizeMake(pageNum *size_width, frame.size.height);
        //设置整页滚动
        scrollView.pagingEnabled = YES;
        //隐藏下面的条
        scrollView.showsHorizontalScrollIndicator = NO;
        //弹簧效果
        scrollView.bounces = NO;
        
        [self addSubview:scrollView];
        
        
        //--------------添加button---------------
        //在scrollview 上添加button  设置button宽度为50 距离屏幕为20
        //表示第几页
        NSInteger page = 0;
        
        for (int  i = 0; i <count; i++) {
            //计算当前是第几页
            page = i / 4 + 1;
            //表示当前button是第几页  (frame.size.width - 50 * 4 - 20 * 2) / 3 表示button距离边距是20 button的宽度是50  表示 2个button之间的间距
            CGFloat button_X = ((frame.size.width - 50 * 4 - 20 * 2) / 3 + 50) * i + 20 + 40 * (page - 1)  - (page - 1) *(frame.size.width - 50 * 4 -20 * 2) /3;
            //取出相应的
            LLLineDataModel *model = dataArray[i];
            //创建button
            LLCustomButton *button = [[LLCustomButton alloc]initWithFrame:CGRectMake(button_X, 15, kWidth, frame.size.height - 15) WithTitle:model.line_name imageUrl:[NSString stringWithFormat:@"%@%@",URL_Base,model.pic]];
            
            
            
            
            ////            if (i < 4) {
////                CGFloat button_X = ((frame.size.width - 50 * 4 - 20 * 2) / 3 + 50) * i + 20 * page;
////            }else if (i => 4){
////                CGFloat button_x = size_width *( page - 1) + ((frame.size.width - 50 * 4 - 20 * 2) / 3 + 50) * (i - page/4) + 20 * (page - i/4 - 1);
////            }
//            //50 * i 表示第i个button前面所有的button的宽度
//            CGFloat button_all_width = 50 * i;
//            //设置第i个button前面的button的间隔
//            CGFloat button_all_place = (frame.size.width - 50 * 4 - 20 * 2) / 3 * page * 3  ;
//            //创建button
//            LLCustomButton *button = [[LLCustomButton alloc]initWithFrame:CGRectMake(button_X, 15, kWidth, frame.size.height - 15) title:titleArray[i] imageName:imageArray[i]];
            //设置button的tag值 来作为button被点击时的坐标
            
            
            button.tag = 2000 + i ;
            //添加到scrollview 上
            [scrollView addSubview:button];
            //给button添加点击事件
            [button addTarget:self action:@selector(ShipLinebuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;

    
    }
//航线的点击按钮
-(void)ShipLinebuttonClicked:(UIButton *)sender{
    _ShipLineButtonClick(sender.tag);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
