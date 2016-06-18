//
//  LLShipDetailViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/8.
//  Copyright © 2016年 taobao. All rights reserved.
//

//邮轮详情页面
#import "LLShipDetailViewController.h"
#import "LLNetWorkManage.h"
#import "SDCycleScrollView.h"
#import "LLShipBannerView.h"
#import "LLShipIntroduceCell.h"
#import "LLShipSelectHeaderView.h"
#import "LLSailDateCell.h"
#import "LLProductFeatureCell.h"
#import "LLRoomDataModel.h"
#import "LLDaysModel.h"
#import "LLRoomCell.h"
#import "LLRouteDateCell.h"
#import "LLFirstRouteDateCell.h"
#import "LLRouteDetailViewController.h"
#import "LLFillOrderViewController.h"


#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import "UMSocial.h"



//----------button 点击tag
#define kSummaryButton_Tag 111
#define kRouteButton_Tag 222
//---------



@interface LLShipDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>

@property(nonatomic,strong)NSMutableArray *cycleViewPicURLArray;//用于存放轮播图路径

@property(nonatomic,strong)NSDictionary *dataDic;//存放邮轮详情data数据---最外层的字典对象
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *coverView;


//存放邮轮简介 ---在数据请求成功的时候 赋值
@property(nonatomic,copy)NSString *shipIntroduceStr;

//懒加载筛选区头
@property(nonatomic,strong)LLShipSelectHeaderView * headerView;

//
@property(nonatomic,assign)BOOL isSummary; //YES 表示 概述按钮 NO 表示点击的是形成按钮




//存放房间的数据源
@property(nonatomic,strong)NSMutableArray *roomArray;
//存放行程的数据
@property(nonatomic,strong)NSMutableArray *daysArray;



//记录一开始偏移量
@property(nonatomic,assign)CGFloat old_contentOffset;
@end


@implementation LLShipDetailViewController
-(NSMutableArray *)cycleViewPicURLArray{
    if (!_cycleViewPicURLArray) {
        self.cycleViewPicURLArray = [NSMutableArray array];
    }
    return _cycleViewPicURLArray;
}
-(NSDictionary *)dataDic{
    if (!_dataDic) {
        self.dataDic = [NSDictionary    dictionary];
    }
    return _dataDic;
}

-(LLShipSelectHeaderView *)headerView{
    if (!_headerView) {
        self.headerView = [[LLShipSelectHeaderView alloc]initWithFrame:CGRectMake(0, 10, size_width, 30)];

    }
    return _headerView;
}

-(NSMutableArray *)roomArray{
    if (!_roomArray) {
        self.roomArray = [NSMutableArray array];
    }
    return _roomArray;
}

-(NSMutableArray *)daysArray{
    if (!_daysArray) {
        self.daysArray = [NSMutableArray array];
    }
    return _daysArray;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    [self loadData];
    
    //注册航线
    [self.tableView registerNib:[UINib nibWithNibName:@"LLShipIntroduceCell" bundle:nil] forCellReuseIdentifier:@"LLShipIntroduceCell"];
    
    //注册开航日期cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LLSailDateCell" bundle:nil] forCellReuseIdentifier:@"LLSailDateCell"];
    
    //注册产品特色cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LLProductFeatureCell" bundle:nil] forCellReuseIdentifier:@"LLProductFeatureCell"];
    
    //注册 费用说明
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CostCell"];
    //注册预定须知
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: @"BookCell"];
    
    //注册房间的cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LLRoomCell" bundle:nil] forCellReuseIdentifier:@"LLRoomCell"];
    
    //注册邮轮cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LLRouteDateCell" bundle:nil] forCellReuseIdentifier:@"LLRouteDateCell"];
    
    //注册邮轮的第一个cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LLFirstRouteDateCell" bundle:nil] forCellReuseIdentifier:@"LLFirstRouteDateCell"];
    
    
    //设置自适应
    self.tableView.estimatedRowHeight = 300;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //默认进来选择的是概述
    _isSummary = YES;
    
    //防止刷
    __weak typeof (self)weakSelf = self;
    //----------------实现点击区头筛选
    self.headerView.buttonClick = ^(NSInteger index){
        switch (index) {
            case kSummaryButton_Tag:
                //点击的概述
                {
                    NSLog(@"点击了概述");
                    _isSummary = YES;
                    weakSelf.tableView.tableFooterView = [[UIView alloc]init];
                }
                break;
                case kRouteButton_Tag:
                //点击的行程
                {
                NSLog(@"点击了形参");
                    _isSummary = NO;
                    //添加表尾
                    [weakSelf addTableViewFooter];
                }
                break;
                
            default:
                break;
        }
        //刷新分区
        [weakSelf.tableView reloadData];
        // --------设置上面两个section按钮
        [weakSelf.tableView setContentOffset:CGPointMake(0, weakSelf.old_contentOffset) animated:YES];
    };
}


#pragma mark----------添加黄色的表尾部---------
-(void)addTableViewFooter{
    //---------给行程添加更多加载按钮--------------
    UIView *FooterVC = [[ UIView alloc]initWithFrame:CGRectMake(0, 0, size_width, 40)];
    //添加button点击 事件
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = FooterVC.frame;
    [button setTitle:@"点击查看行程详情" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(MoreButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [FooterVC addSubview:button];
    button.backgroundColor = [UIColor orangeColor];
    
    self.tableView.tableFooterView = FooterVC;
}
#pragma mark -------点击行程的加载更多按钮--------
-(void)MoreButtonClickAction:(UIButton *)sender{
    NSLog(@"是谁点了行程的加载跟多按钮..........");
    LLRouteDetailViewController *daysDetailVC = [[LLRouteDetailViewController alloc]init];
    daysDetailVC.daysDataArray = [NSArray arrayWithArray:self.daysArray];
    [self presentViewController:daysDetailVC animated:YES completion:nil];
}




#pragma mark ----- 加载数据
-(void)loadData{
    
    NSLog(@"ID--------%@",_product_id);
    //请求详情数据
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",URL_ShipDetail,_product_id];
    [LLNetWorkManage requestGetWithUrlStr:urlStr paramDict:nil finish:^(id responseObejct) {
        NSLog(@"llllll-------%@",responseObejct);
        //数据请求成功
        //接收返回成功的数据
        NSDictionary *returnDic = [NSDictionary dictionaryWithDictionary:responseObejct];
        //把接收的最外层的字典数据 让全局字典拿着
        self.dataDic = [returnDic objectForKey:@"data"];
        

     
        
        //取出轮播图上的图片urlStr --直接拼接基本路径
        for (NSDictionary * dic in [self.dataDic objectForKey:@"album_list"] ) {
            NSString *picStr = [NSString stringWithFormat:@"%@%@",URL_Base,[dic objectForKey:@"picture"]];
            [self.cycleViewPicURLArray addObject:picStr];
        }
        
        //---------行程中的房间数据------------
        //变量room下的所有数组------各个类型的房间------放到模型中
        for (NSArray *roomArr in [[self.dataDic objectForKey:@"room"] allValues]) {
            //取出不同类型房间下的房间数据
            for (NSDictionary *roomDic in roomArr) {
                LLRoomDataModel *model = [[LLRoomDataModel alloc]init];
                [model setValuesForKeysWithDictionary:roomDic];
                [self.roomArray addObject:model];
            }
            NSLog(@"roomArray =======  %@",self.roomArray);
        }
        //--------日期的行程数据获取---------
        NSDictionary *shcduleDic = [self.dataDic objectForKey:@"schedule"];
        for (int i = 1; i < shcduleDic.allKeys.count + 1; i++) {
            //取出相对应的天数
            NSDictionary *dayDic = [shcduleDic objectForKey:[NSString stringWithFormat:@"%d",i]];
            LLDaysModel *model = [[LLDaysModel alloc]init];
            [model setValuesForKeysWithDictionary:dayDic];
            [self.daysArray addObject:model];
        }
        
        
           [self.tableView reloadData];
           [self loadSubViews];
        //隐藏 网络请求成功  将白色视图隐藏
        self.coverView.hidden = YES;
       
    } enError:^(NSError *error) {
        //数据请求失败
        
        
    }];
 
}

#pragma mark --------布局子视图
-(void)loadSubViews{
    self.title = @"邮轮详情";
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"分享1@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(ShareButtonAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    //创建表头
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size_width, 220)];
//    headerView.backgroundColor  = [UIColor redColor];
    self.tableView.tableHeaderView = headerView;
    
    //---------------创建轮播图
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, size_width, 150) imageURLStringsGroup:self.cycleViewPicURLArray];
    //-------------创建显示的出发地和航线的bannerView
    LLShipBannerView *bannerView = [[LLShipBannerView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(cycleScrollView.frame) - 30, size_width, 30)];
    //把里面的数据展示到对应的航线和出发
    bannerView.LineLab.text = [self.dataDic objectForKey:@"line_name"];
    bannerView.portLab.text = [self.dataDic objectForKey:@"harbor_name"];
    [cycleScrollView addSubview:bannerView];
    [headerView addSubview:cycleScrollView];
    
    //------------创建展示product_name的lab
    UILabel *productLab = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(cycleScrollView.frame), size_width - 20 * 2, 40)];
    productLab.numberOfLines  = 0;
    productLab.lineBreakMode = NSLineBreakByWordWrapping;
    productLab.font = [UIFont systemFontOfSize:14];
    productLab.text = [self.dataDic objectForKey:@"product_name"];
    [headerView  addSubview:productLab];
    
    
    //--------------创建展示价格lab
    UILabel *priceLab = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(productLab.frame), size_width - 20 * 2, 30)];
    NSString *price_str = [self.dataDic objectForKey:@"min_price"];
    NSString *completeStr = [NSString stringWithFormat:@"微旅价:￥%@起",price_str];
    //创建一个属性字符串
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:completeStr];
    //设置属性
    [attributedStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} range:NSMakeRange(0, 4)];
    [attributedStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} range:NSMakeRange(attributedStr.length - 1, 1)];
    //设置中间的文字
    [attributedStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:[completeStr rangeOfString:[NSString stringWithFormat:@"￥%@",price_str]]];
    //设置文字的演示
    [attributedStr setAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(0, completeStr.length - 1)];
    priceLab.attributedText = attributedStr;
    [headerView addSubview:priceLab];
    
    //------------------------------
    
    
    
    
}
#pragma mark ------分享按钮的点击事件
-(void)ShareButtonAction:(UIBarButtonItem *)barButton{
    NSLog(@"-----------点击了分享按钮.......");
    
    
    [UMSocialData setAppKey:@"558a3b9767e58edac60036e4"];
    
    //存放当前显示的存放平台
    NSMutableArray *plantFormArr = [[NSMutableArray alloc] init];
    //添加短信平台
    [plantFormArr addObject:UMShareToSms];
    //判断当前是否安装微信，添加微信好友、朋友圈、和收藏
    if ([WXApi isWXAppInstalled]) {
        [plantFormArr addObject:UMShareToWechatSession];
        [plantFormArr addObject:UMShareToWechatTimeline];
        //        [plantFormArr addObject:UMShareToWechatFavorite];
    }
    //判断是否安装qq，添加qq好友和qq空间平台
    if ([QQApiInterface isQQInstalled]) {
        [plantFormArr addObject:UMShareToQQ];
        [plantFormArr addObject:UMShareToQzone];
        [UMSocialData defaultData].extConfig.qzoneData.title = @"欢迎使用管车易";
        [UMSocialData defaultData].extConfig.qzoneData.url = @"www.guancheyi.com";
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:@"http://121.199.38.85/guancheyi/public/uploads/event_img/user_4/2015091717/55fa8b5cdd03b.jpg"];
    }
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"558a3b9767e58edac60036e4"
                                      shareText:@"北京掌上先机网络科技有限公司，www.guancheyi.com"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:plantFormArr  //微信好友、朋友圈、微信收藏、短信
                                       delegate:self];
    
    
    
    

}

#pragma mark -------UITableViewDataSource-------
//分区个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            if (_isSummary) {
                return 2;
            }else{
                return self.roomArray.count;
            }
            break;
        case 2:
            
            if (_isSummary) {
                return 2;
            }else{
                return _daysArray.count;
            }
    
            break;
        default:
            break;
    }
    return 0;
}
//返回cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath    {
    
    
    
    
    
    if (indexPath.section == 0) {
        LLShipIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLShipIntroduceCell" forIndexPath:indexPath];
        //根据邮轮介绍的内容改变箭头的方法
        if (self.shipIntroduceStr.length > 0) {
            //设置箭头朝下
            cell.imgView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        }else{
            cell.imgView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        //把标签字符串 转换成字符串
        NSAttributedString *attribuSr = [[NSAttributedString alloc]initWithData:[self.shipIntroduceStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        cell.shipintroduceLab.attributedText = attribuSr;
        //处理</br>的换行
        //去掉cell的lab上的换行
        NSString *tempStr = cell.shipintroduceLab.text;
        //
        tempStr = [tempStr stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        cell.shipintroduceLab.text = tempStr;
    
        //把cell 上的效果关掉
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if(indexPath.section == 1){
#warning ---------
        if (_isSummary) {
            
        
        
        if (indexPath.row == 0) {
            //返回开航日期的cell
            LLSailDateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLSailDateCell" forIndexPath:indexPath];
            //取出返回的出发时间 s ----
            NSString *setoff_date = [self.dataDic objectForKey:@"setoff_date"];
            //把时间
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[setoff_date doubleValue]];
            //定义一个时间格式
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            //换算当前是周几
            NSString *sailTimeDay = [self featureWeekdayWithDate:[formatter stringFromDate:date]];
            //拼接当前日期和周几赋值给lab
            NSString *completeTimeStr = [NSString stringWithFormat:@"%@%@",[formatter  stringFromDate:date],sailTimeDay];
            //展示到cell 上
            cell.SailDateLab.text = completeTimeStr;
            
            return cell;
            
        }else if (indexPath.row == 1){
            LLProductFeatureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLProductFeatureCell" forIndexPath:indexPath];
            //找到接口 返回的features数据
            NSString *featuresStr = [self.dataDic objectForKey:@"features"];
            //把标签字符串 转换成字符串
            NSAttributedString *attribuSr = [[NSAttributedString alloc]initWithData:[featuresStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
            cell.featureLab.attributedText = attribuSr;
            
            return cell;
        }
        }else{
            //说明当前点击的是行程按钮 section == 1的时候 返回房间数据
            LLRoomCell *RoomCell = [tableView dequeueReusableCellWithIdentifier:@"LLRoomCell" forIndexPath:indexPath];
            //获取数据
            LLRoomDataModel *model = self.roomArray[indexPath.row];
            [RoomCell setCellDataWith:model];
            //点击cell上的按钮
            RoomCell.buttonClicked= ^(NSString *type_name){
                NSLog(@"点击了预定房间");
                //跳转到相应的订单页面
                LLFillOrderViewController *fillOrderVC = [[LLFillOrderViewController alloc]init];
                fillOrderVC.roomTypeStr = type_name;
                fillOrderVC.dataDic =[NSDictionary dictionaryWithDictionary:self.dataDic];
                [self.navigationController pushViewController:fillOrderVC animated:YES];
            };
            return RoomCell;
        }
    }else{
         //判断第3个分区中显示的内容是概述还是行程
        if (_isSummary) {
            //返回概述数据
        
        if (indexPath.row == 0) {
            //返回费用说明cell
            UITableViewCell *costcell = [tableView dequeueReusableCellWithIdentifier:@"CostCell" forIndexPath:indexPath];
            costcell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            costcell.textLabel.text = @"费用说明";
            costcell.textLabel.font = [UIFont systemFontOfSize:14];
            costcell.imageView.image = [UIImage imageNamed:@"new费用说明"];
            costcell.selectionStyle = UITableViewCellAccessoryNone;
            return costcell;
            
        }else if(indexPath.row == 1){
           
            //预定须知
            UITableViewCell *bookcell = [tableView dequeueReusableCellWithIdentifier:@"BookCell" forIndexPath:indexPath];
            bookcell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            bookcell.textLabel.text = @"预定须知";
            bookcell.textLabel.font = [UIFont systemFontOfSize:14];
            bookcell.imageView.image = [UIImage imageNamed:@"new预定须知@2x"];
            bookcell.selectionStyle = UITableViewCellAccessoryNone;
            return bookcell;
            
            
        }
        }else {
            
            LLDaysModel *model = self.daysArray[indexPath.row];
            //当前为行程的section == 2的分区
            if (indexPath.row == 0) {
                LLFirstRouteDateCell *firstCell = [tableView dequeueReusableCellWithIdentifier:@"LLFirstRouteDateCell" forIndexPath:indexPath];
                return firstCell;
            }else{
                LLRouteDateCell *routeCell = [tableView dequeueReusableCellWithIdentifier:@"LLRouteDateCell" forIndexPath:indexPath];
                [routeCell setCellDataWith:model];
                return routeCell;
            }
            
            
        }
    }
       return [[UITableViewCell alloc]init];
}
//cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        
        //获取点击的cell
//        LLShipIntroduceCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        
        //判断cell上的lab是否有值
        if (self.shipIntroduceStr.length > 0) {
          self.shipIntroduceStr = @"";
        }else{
            self.shipIntroduceStr = [self.dataDic objectForKey:@"features_sub"];
        }
        //刷新这行
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath  indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
}
//返回区头的
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size_width, 40)];
        //-----------实现点击了block----
        //-------可以随时写了
        backView.backgroundColor   = [UIColor colorWithWhite:0.95 alpha:1.0];
        [backView addSubview:self.headerView];
        return backView;
    }
    return [[UIView alloc]init];
}
//返回区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section    {
    if (section == 1) {
        return 40;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return -1;
    }else if(indexPath.section == 1){
        if (!_isSummary) {
            return 100;
        }
        return -1;
    }else if(indexPath.section == 2){
        if (!_isSummary) {
            return 214;
        }
    }
    return -1;
}


//添加足尾
//-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (!_isSummary) {
//        if (section == 2) {
//            UIView *footerVc = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size_width, 100)];
//            footerVc.backgroundColor = [UIColor orangeColor];
//            return footerVc;
//        }
//    }
//    return [[UIView alloc]init];
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (!_isSummary) {
//        if (section == 2) {
//            return 100;
//        }
//    }
//    return 0;
//}
#pragma mark------获取未来 某个时间 是礼拜几

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

#pragma mark ---
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _old_contentOffset = scrollView.contentOffset.y;
    
    //定义一个区头的高度
    CGFloat sectionHeaderHeight = 40;
    //当前scrollview的偏移量小于区头高度 并且当当前scrollview没有离开屏幕的时候,设置scrollview的内容视图的inset为scrollview的偏移量
    if (scrollView.contentOffset.y < sectionHeaderHeight && scrollView.contentOffset.y > -64) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    }else if(scrollView.contentOffset.y >sectionHeaderHeight){
        //当scrollview的偏移量大于区头高度的时候吗改变区头的内容视图的inset -sectionHeaderHeight 使headerView的悬浮位置改变屏幕内容
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
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
