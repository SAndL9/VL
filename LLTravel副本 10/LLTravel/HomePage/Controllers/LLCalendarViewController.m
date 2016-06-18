//
//  LLCalendarViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/12.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLCalendarViewController.h"
#import "CalenderView.h"
#import "LLCalendarModel.h"
@interface LLCalendarViewController ()

@property(nonatomic,strong)NSMutableString *selectDate;

@end

@implementation LLCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //创建邮轮日历
    self.title = @"邮轮日历";
    CalenderView *calenderView = [CalenderView createCalenderView];
    calenderView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y+64, self.view.bounds.size.width, self.view.bounds.size.height-64);
    [self.view addSubview:calenderView];
    
    
    //给日历赋值
    //取出传递过来的model的ymd 日期
    NSMutableArray  *ymdArr = [NSMutableArray array];
    for (LLCalendarModel * model in self.calendarArr) {
        [ymdArr addObject:model.ymd];
    }
    
    [calenderView showSignWithArray:ymdArr];
    

    
    calenderView.CalenderBlock=^(NSString *string){
        _selectDate = (NSMutableString*)string;
        NSLog(@"选择了11111.......%@",string);
        
        //----转换成data 然后请求数据
        //得到相差秒数
      
  
        
        

        
    
 
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [dateFormatter  dateFromString:string];
        //得到相差秒数
        NSTimeInterval time = [date timeIntervalSinceDate:[NSDate date]];
        NSLog(@"---------%f",time);
        
        
    };
     NSLog(@"选择了.......%@",_selectDate);
    
   
}
#pragma mark-------
-(void)loadSubViews{
    self.view.backgroundColor = [UIColor whiteColor];
  
    
    
   
}
#pragma mark--------
-(void)loadData{
    
    
    
}

//-------








//--------------------------------------------------------

    /**
     *  获取未来某个日期是星期几
     *  注意：featureDate 传递过来的格式 必须 和 formatter.dateFormat 一致，否则endDate可能为nil
     *
     */
- (NSString *)featureWeekdayWithDate:(NSString *)featureDate{
    // 创建 格式 对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置 日期 格式 可以根据自己的需求 随时调整， 否则计算的结果可能为 nil
    formatter.dateFormat = @"yyyy-MM-dd";
    // 将字符串日期 转换为 NSDate 类型
    NSDate *endDate = [formatter dateFromString:featureDate];
    // 判断当前日期 和 未来某个时刻日期 相差的天数
    long days = [self daysFromDate:[NSDate date] toDate:endDate];
    // 将总天数 换算为 以 周 计算（假如 相差10天，其实就是等于 相差 1周零3天，只需要取3天，更加方便计算）
    long day = days >= 7 ? days % 7 : days;
    long week = day;
    switch (week) {
        case 1:
            return @"周日";
            break;
        case 2:
            return @"周一";
            break;
        case 3:
            return @"周二";
            break;
        case 4:
            return @"周三";
            break;
        case 5:
            return @"周四";
            break;
        case 6:
            return @"周五";
            break;
        case 7:
            return @"周六";
            break;
            
        default:
            break;
    }
    return nil;
}
/**
 *  计算2个日期相差天数
 *  startDate   起始日期
 *  endDate     截至日期
 */
-(NSInteger)daysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //得到相差秒数
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    int days = ((int)time)/(3600*24);
    int hours = ((int)time)%(3600*24)/3600;
    int minute = ((int)time)%(3600*24)/3600/60;
    if (days <= 0 && hours <= 0&&minute<= 0) {
        NSLog(@"0天0小时0分钟");
        return 0;
    }
    else {
        NSLog(@"%@",[[NSString alloc] initWithFormat:@"%i天%i小时%i分钟",days,hours,minute]);
        // 之所以要 + 1，是因为 此处的days 计算的结果 不包含当天 和 最后一天\
        （如星期一 和 星期四，计算机 算的结果就是2天（星期二和星期三），日常算，星期一——星期四相差3天，所以需要+1）\
        对于时分 没有进行计算 可以忽略不计
        return days + 1;
    }
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
