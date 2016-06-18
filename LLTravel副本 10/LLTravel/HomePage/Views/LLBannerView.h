//
//  LLBannerView.h
//  LLTravel
//
//  Created by lanouhn on 16/6/2.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLBannerView : UIView
//动画鸟
@property (weak, nonatomic) IBOutlet UIImageView *birdAnimationImageView;
//公告tableView
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//声明初始化方法  dataArray 表示传递的公告数据
-(instancetype)initWithFrame:(CGRect)frame withAnnouncementDataArray:(NSArray*)dataArray;
//刷新数据源
-(void)UpdataWithArray:(NSMutableArray*)array;
@end
