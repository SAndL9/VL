//
//  LLBannerView.m
//  LLTravel
//
//  Created by lanouhn on 16/6/2.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLBannerView.h"
#import "LLBannerDetailViewController.h"
@interface LLBannerView ()<UITableViewDataSource,UITableViewDelegate>
//接收传递进来的公告数据
@property(nonatomic,strong)NSMutableArray *dataArr;
//声明一个变量 存储要取的对象的 下标
@property(nonatomic,assign)NSInteger currentIndex;
@end

@implementation LLBannerView


-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
//刷新数据源
-(void)UpdataWithArray:(NSMutableArray*)array{
 
    self.dataArr = array;
}


//声明初始化方法  dataArray 表示传递的公告数据
-(instancetype)initWithFrame:(CGRect)frame withAnnouncementDataArray:(NSArray*)dataArray{
    if (self = [super initWithFrame:frame]) {
        //从nib中找到我们自定义的View -----
        NSArray *viewArray = [[NSBundle mainBundle]loadNibNamed:@"LLBannerView" owner:self options:nil];
        self = viewArray[0];
        self.frame = frame;
        //添加动画
        [self birdFly];
        
        //设置tableView代理为当前View
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
         //设置公告栏最初从第一条开始展示的数据
        self.currentIndex = 0;
        
        //设置分割线类型
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
        //设置公告数据源
        self.dataArr = [NSArray arrayWithArray:dataArray];
        
        //添加定时器 使tableView 滚动
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(tableViewScrollTop) userInfo:nil repeats:YES];
        
        
        

    }
    return self;
}

//定义小鸟飞的方法
-(void)birdFly{
    NSMutableArray *gifArray = [NSMutableArray array];
  
    for (int i = 1; i < 12; i++) {
        //添加图片到数组中
        [gifArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"鸟的煽动动画000%d",i]]];
    }
    
    //设置图片的数组
    self.birdAnimationImageView.animationImages = gifArray;
    //设置图片的运行时间
    self.birdAnimationImageView.animationDuration = 1.0;
    //设置图片的运行次数 0表示无线循环
    self.birdAnimationImageView.animationRepeatCount = 0;
    
    //开始动画
    [self.birdAnimationImageView startAnimating];

}
#pragma mark--------定时器的方法
//实现定时器的方法 2s使tableView 上滑一次
-(void)tableViewScrollTop{
   
    //判断当前数据源是不是最后一个
    if (_currentIndex == self.dataArr.count - 1) {
        //将要展示的数据源 设置成第一个
        self.currentIndex = 0;
    }else{
        //不是第一个
        self.currentIndex++;
    }
    
    //实现上滑滚动
     [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationTop];
    
}


#pragma mark -------UITableViewDataSource && UITableViewDatagate---------
//设置分区行数  返回一行公告栏
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
//cell 高度  返回公告栏的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;
}
//返回cell  返回展示公告数据的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置重用cell的表示
    static NSString *cellid = @"cellidentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }

    //设置展示的数据源
    cell.textLabel.text = self.dataArr[_currentIndex];
    return cell;
    
}

//点击公告详情 ---- 把公告标识传递进去------根据对应的id
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    LLBannerDetailViewController *detailVc = [[LLBannerDetailViewController alloc]init];
    detailVc.Webtitle = _dataArr[indexPath.row];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:detailVc animated:YES completion:nil];
   
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
