//
//  StewardListCell.m
//  VTravel-0601
//
//  Created by lanouhn on 16/6/6.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "StewardListCell.h"
#import "UIImageView+WebCache.h"
@interface StewardListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *genderAgeLab;
@property (weak, nonatomic) IBOutlet UILabel *ConstellationLab;
@property (weak, nonatomic) IBOutlet UILabel *caseLab;
@property (weak, nonatomic) IBOutlet UILabel *levelLab;
@property (weak, nonatomic) IBOutlet UILabel *advantageLab;


@end

@implementation StewardListCell

//配置cell的数据 根据传递的数据 给cell赋值
-(void)setupDataWith:(LLStewardListModel*)model{
    
    //配置头像URL
    NSString *imagUrlStr = [NSString stringWithFormat:@"%@/%@",URL_Base,model.avatar];
    [self.headerImageView  sd_setImageWithURL:[NSURL URLWithString:imagUrlStr]];

    //name
    self.nameLab.text = model.name;
    //案例
    self.caseLab.text = model.order_count;
    //设置评分
    self.levelLab.text = model.level;
    //简介
    self.advantageLab.text = model.advantage;
    //性别 年龄
    if ([@"1" isEqualToString:model.gender]) {
        self.genderAgeLab.text = [NSString stringWithFormat:@"男%@",[self getAge:model.birth_date]];
    }else if([@"2" isEqualToString:model.gender]){
        self.genderAgeLab.text = [NSString stringWithFormat:@"女%@",[self getAge:model.birth_date]];
    }
    //星座
    NSString *item;
    switch ([model.horoscope intValue]) {
            case 1:
            {
                item = @"白羊座";

            }
                break;
            
                
            case 2:
            {
                item=@"金牛座";
               

            }
                break;
                
            case 3:
            {
                item=@"双子座";
            }
                break;
            case 4:
            {
                item=@"巨蟹座";
            }
                break;
            case 5:
            {
                item=@"狮子座";
            }
                break;
            case 6:
            {
                item=@"处女座";
            }
                break;
            case 7:
            {
                item=@"天秤座";
            }
                break;
            case 8:
            {
                item=@"天蝎座";
            }
                break;
            case 9:
            {
                item=@"射手座";
            }
                break;
            case 10:
            {
                item=@"摩羯座";
            }
                break;
            case 11:
            {
                item=@"水瓶座";
            }
                break;
            case 12:
            {
                item=@"双鱼座";
                
            }
            break;
    
    }
    self.ConstellationLab.text = [NSString stringWithFormat:@"%@",item];

    
}
//设置出生日期
-(NSString *)getAge:(NSString *)brith_age{
    if ([brith_age isEqualToString:@"0"]) {
        return @"0";
    }
    else{
        //创建日期格式
        NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
        [dataFormatter setDateFormat:@"yyyy-MM-dd"];
        
        //创建两个时间对象
        NSDate *longdate = [dataFormatter dateFromString:brith_age];
        NSDate *currentdate = [NSDate date];
        
        //进行判断 然后实现 两者之间的距离
        NSTimeInterval time = [currentdate timeIntervalSinceDate:longdate];
        int days = (int)time / 3600 / 24;
        int age = days / 365;
        NSString *ageStr = [NSString stringWithFormat:@"%d",age];
        return ageStr;
    }
    
    
}

- (void)awakeFromNib {
    // Initialization code
    self.advantageLab.text = @"afasdasdsadsadasdsaasfaskljasolaskjldjcvlasasdlsafnvsaqfffff";
    
    //设置头像圆角
    self.headerImageView.layer.cornerRadius = CGRectGetWidth(_headerImageView.frame)/ 2;
    self.headerImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
