//
//  CalenderView.h
//  VTravel
//
//  Created by zhangmeng on 16/6/12.
//  Copyright © 2016年 Lanou. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface CalenderView : UIView<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)NSDate *date;
//日历表的数据源
@property(nonatomic,strong)NSMutableArray *dateArray;
//标记数据源
@property(nonatomic,strong)NSArray *signArray;

//把日期回掉出去
@property(nonatomic,copy)void(^CalenderBlock)(NSString *str);




// 月份显示
@property (weak, nonatomic) IBOutlet UILabel *showDateLabel;
//时间显示
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//事件显示
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//前一个月
- (IBAction)clickPreBtn:(id)sender;
//后一个月
- (IBAction)clickNextBtn:(id)sender;
+ (instancetype)createCalenderView;

//显示标记方法
- (void)showSignWithArray:(NSArray *)array;


@end
