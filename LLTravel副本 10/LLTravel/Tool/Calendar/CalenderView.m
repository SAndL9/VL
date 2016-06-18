//
//  CalenderView.m
//  VTravel
//
//  Created by zhangmeng on 16/6/12.
//  Copyright © 2016年 Lanou. All rights reserved.
//

#import "CalenderView.h"
#import "CalenderCell.h"
#import "CalendarCellModel.h"

static NSString * const CALENDER = @"CalenderCell";
@interface CalenderView()
{
    //对应的星期
    NSArray *timerArray;
    //本月的总天数
    NSMutableArray *allDayArray;

    //获得点击事件
    NSMutableArray *selctArray;
}
@end
@implementation CalenderView
/**
 *  构造方法
 *
 */
+ (instancetype)createCalenderView{

    CalenderView *calenderView = [[[NSBundle mainBundle]loadNibNamed:@"CalenderView" owner:nil options:nil] lastObject];
    return calenderView;
}
- (void)awakeFromNib{
    
    timerArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
    self.dateArray = [NSMutableArray arrayWithCapacity:1];
    
    _date = [NSDate date];
    [self setShowDateLabelString:_date];
    
    
    [self reloadDataTimeArray];

    [self setCollectionViewLayout];
    //九宫格
    [_collectionView registerNib:[UINib nibWithNibName:CALENDER bundle:nil] forCellWithReuseIdentifier:CALENDER];
}
/**
 *  点击上月
 *
 */
- (IBAction)clickPreBtn:(id)sender {
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:_date options:0];
    [self setShowDateLabelString:newDate];
    _date = newDate;
    [self reloadDataTimeArray];
}
//获取最新的日期表
- (void)reloadDataTimeArray
{
    //获得本月第一天在星期几
    allDayArray = [NSMutableArray array];
    
    NSInteger day = [self currentFirstDay:_date];
    for (NSInteger i = 0; i < day; i++){
        [allDayArray addObject:@""];
    }
    
    NSInteger days = [self currentMonthOfDay:_date];
    
    for (NSInteger i = 1; i <= days; i++) {
        [allDayArray addObject:@(i)];
    }
    //把剩下的空间置为空
    for (NSInteger i = allDayArray.count; i < 42; i ++) {
        [allDayArray addObject:@""];
    }

    [self.dateArray removeAllObjects];
    for (int i = 0; i < allDayArray.count; i ++) {
        CalendarCellModel * mod = [[CalendarCellModel alloc] init];
        mod.dateStr = [NSString stringWithFormat:@"%@",[allDayArray objectAtIndex:i]];
        [self.dateArray addObject:mod];
    }
    
    [self showSignWithArray:self.signArray];
    
}

- (IBAction)clickNextBtn:(id)sender {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:_date options:0];
    [self setShowDateLabelString:newDate];
    _date = newDate;
    
    [self reloadDataTimeArray];
}
/**
 *  设置九宫格的属性
 */
- (void)setCollectionViewLayout{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    layout.itemSize = CGSizeMake(width / 7, width / 10);
    layout.minimumLineSpacing = 0.0;
    layout.minimumInteritemSpacing = 0.0;
    
    [_collectionView setCollectionViewLayout:layout];
}
/**
 *  label的set方法
 *
 */
- (void)setShowDateLabelString:(NSDate *)date{

    self.showDateLabel.text = [NSString stringWithFormat:@"%li年%li月",(long)[self currentYear:date],(long)[self currentMonth:date]];
}
/**
 *  获取当前月的年份
 */
- (NSInteger)currentYear:(NSDate *)date{

    NSDateComponents *componentsYear = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [componentsYear year];
}
/**
 *  获取当前月的月份
 */
- (NSInteger)currentMonth:(NSDate *)date{

    NSDateComponents *componentsMonth = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [componentsMonth month];
}
/**
 *  获取当前是哪一天
 *
 */
- (NSInteger)currentDay:(NSDate *)date{

    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}
/**
 *  本月有几天
 *
 */
- (NSInteger)currentMonthOfDay:(NSDate *)date{

    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}
/**
 *  本月第一天是星期几
 *
 */
- (NSInteger)currentFirstDay:(NSDate *)date{

    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];//1.mon
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

//显示标记方法
- (void)showSignWithArray:(NSArray *)array
{
    self.signArray = array;
    
    NSMutableArray * temArray = [NSMutableArray arrayWithCapacity:1];
    for (NSString * str in array) {
        [temArray addObject:[self replaceArrayWithStrArray:str]];
    }
    
    for (CalendarCellModel * mod in self.dateArray) {
        for (NSArray * arr in temArray) {
            
            //标记年月日.
            NSInteger sginYear = [arr[0] integerValue];
            NSInteger sginMouth = [arr[1] integerValue];
            NSInteger sginDay = [arr[2] integerValue];
            
            ///cell上的年月日
            NSInteger cellYear = [self currentYear:_date];
            NSInteger cellMouth = [self currentMonth:_date];
            NSInteger cellDay = [mod.dateStr integerValue];
            
            if (sginDay == cellDay && sginYear == cellYear && sginMouth == cellMouth) {
                mod.isSign = YES;
            }
            
        }
    }
    
    [self.collectionView reloadData];
}
//2016-02-05 转换成数组[2016, 02, 05];
- (NSArray *)replaceArrayWithStrArray:(NSString *)str
{
    NSArray * arr = [str componentsSeparatedByString:@"-"];
    return arr;
}


#pragma mark-----------------------------
#pragma mark-----表的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return selctArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * const ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:ID];
    }
    cell.textLabel.text = selctArray[indexPath.row];
    return cell;
}
#pragma mark-----------------------------
#pragma mark---九宫格代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return timerArray.count;
    } else {
        return 42;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CalenderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CALENDER forIndexPath:indexPath];
    cell.signImageView.hidden = YES;
    if (indexPath.section == 0) {
        cell.dateLabel.text = timerArray[indexPath.row];
        cell.dateLabel.font = [UIFont systemFontOfSize:14];
        switch (indexPath.row) {
            case 5:
            {
                cell.dateLabel.textColor = [UIColor redColor];

            }
                break;
            case 6:
            {
                cell.dateLabel.textColor = [UIColor redColor];
            }
                break;
                
            default:
            {
                cell.dateLabel.textColor = [UIColor cyanColor];
            }
                break;
        }
        
        
    }else{
        CalendarCellModel * mod = [self.dateArray objectAtIndex:indexPath.row];
        
        cell.dateLabel.textColor = [UIColor blackColor];
        cell.dateLabel.text = [NSString stringWithFormat:@"%@",mod.dateStr];
        if (mod.isSign) {
            cell.signImageView.hidden = NO;
        }else{
            cell.signImageView.hidden = YES;
        }
                
        if ([allDayArray[indexPath.row] isEqual:@""]) {
        }

    }
    return cell;
}
/**
 *  选择单元格
 *
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSString *cellString = allDayArray[indexPath.row];
    if (![cellString isEqual:@""]) {
        NSLog(@"*%li年 %li月 %@日 ",(long)[self currentYear:_date],(long)[self currentMonth:_date],cellString);
        NSString *dayStr = [NSString stringWithFormat:@"%li-%li-%@",(long)[self currentYear:_date],(long)[self currentMonth:_date],cellString];
        NSLog(@"*****************%@",dayStr);
        selctArray = [NSMutableArray arrayWithObject:dayStr];
        NSLog(@"++@+@+@+@+@+@%@",selctArray);
        [self.tableView reloadData];
        _CalenderBlock(dayStr);
        
    }
}





@end
