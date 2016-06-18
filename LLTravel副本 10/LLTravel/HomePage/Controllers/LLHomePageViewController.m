//
//  LLHomePageViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/2.
//  Copyright © 2016年 taobao. All rights reserved.
//



#import "LLHomePageViewController.h"
#import <CoreLocation/CoreLocation.h>

#import <SDCycleScrollView/SDCycleScrollView.h>
#import "LLCustomView.h"
#import "LLBannerView.h"
#import "LLPeripheralFeatureSpotView.h"
#import "LLTravelDestinationView.h"
#import "LLSectionHeaderView.h"
#import "LLNetWorkManage.h" //封装的网络请求类
#import "LLCycleScrollViewDataModel.h"
#import "LLJSWebViewController.h"
#import "LLStewardViewController.h"
#import "LLPeripheraModel.h"
#import "LLBannerModel.h"
#import "LLShipCell.h"
#import "LLShipModel.h"
#import "LLTicketModel.h"
#import "LLStudyModel.h"
#import "LLShipViewController.h"
#import "LLMoreTravelDestinationViewController.h"
#import "LLShipDetailViewController.h"
#import "LLDetailTravelViewController.h"
#import "LLMorePeripheralViewController.h"
#import "LLTraelViewController.h"
#import "LLTicketViewController.h"

#import "LLCityListViewController.h"

#define kTableView_headerHeight 900 //HeaderView的高度
#define kTableView_Tag  444 // 当前主界面的tableView
#define kLocationBtn_Tag 555 //标识定位的地方

@interface LLHomePageViewController () <UITableViewDataSource,UITableViewDelegate,LLTravelDestinationViewDelegate,LLSectionHeaderViewDelegate,SDCycleScrollViewDelegate,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;
//轮播图的数据源.......
@property(nonatomic,strong)NSMutableArray *cycleScrollviewDataArray;

//公告
@property(nonatomic,strong)LLBannerView * bannerView;
//推荐
@property(nonatomic,strong)LLCustomView * customView;

//旅游景点
@property(nonatomic,strong)LLTravelDestinationView * travelDestinationView;

@property(nonatomic,strong)NSMutableArray *TraveDataArray;

//周边景点的数据源
@property(nonatomic,strong)NSMutableArray *PerDataArray;
@property(nonatomic,strong)LLPeripheralFeatureSpotView *peripheralView;

//邮轮
@property(nonatomic,strong)NSMutableArray *shipDataArray;
@property(nonatomic,strong)NSMutableArray *ticketDataArray;//门票数据源
@property(nonatomic,strong)NSMutableArray *studyDataArray; //游学数据源
@property(nonatomic,strong)NSMutableArray *tempDataArray;//临时数据源

@property(nonatomic,assign)NSInteger index;

@property(nonatomic,strong)LLSectionHeaderView *headrView;//用于接收头视图

@property(nonatomic,strong)UIView *customNaviBarView;//用来展示定位 搜索 和扫描的视图



// 设置位置管理器
@property(nonatomic,strong)CLLocationManager *locationManager;
// 地理编码和反编码
@property (nonatomic, strong)CLGeocoder *geocoder;


@end

static NSString *cellID = @"cellid";
@implementation LLHomePageViewController

-(NSMutableArray *)cycleScrollviewDataArray{
    if (!_cycleScrollviewDataArray) {
        self.cycleScrollviewDataArray = [NSMutableArray array];
    }
    return _cycleScrollviewDataArray;
}
// 反编码懒加载
- (CLGeocoder *)geocoder {
    if (!_geocoder) {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}


//lazy  避免 重复加载头实体 以防止出现上面的轮滑不能切换
-(LLSectionHeaderView *)headrView{
    if (!_headrView) {
        self.headrView =  [[LLSectionHeaderView alloc]initWithFrame:CGRectMake(0, 0, size_width, 40)];
        _headrView.delegate = self;
    }
    return _headrView;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //隐藏customNaviBarView
    _customNaviBarView.hidden = YES;
    //设置navigationBar不透明
    [self.navigationController.navigationBar setBackgroundImage:[self getImageWithAlpha:1.0] forBarMetrics:UIBarMetricsDefault];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _customNaviBarView.hidden = NO;
    //设置navbar的透明度 调用这句话的目的是为了保持主界面消失的时候 导航栏的透明度.
    [self scrollViewDidScroll:self.tableView];
//     [self.navigationController.navigationBar setBackgroundImage:[self getImageWithAlpha:0] forBarMetrics:UIBarMetricsDefault];
    //隐藏navigationBar
    self.navigationController.navigationBar.hidden = NO;
    
   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.PerDataArray = [NSMutableArray array];
    [self loadSubViews];
    [self loadData];
    
    self.shipDataArray = [NSMutableArray array];
    self.ticketDataArray = [NSMutableArray array];
    self.studyDataArray = [NSMutableArray array];
    self.tempDataArray = [NSMutableArray array];
    //注册cell
    [self.tableView registerClass:[LLShipCell class] forCellReuseIdentifier:cellID];
    self.tableView.rowHeight = 100;
   


    [self customLocation];
    
  
    
    
}
//隐藏下划线的效果 ---设置nav的透明
-(void)setNaviBar{
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    //隐藏navbar上的默认的下划线
        self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
    //---------
    //1.获取navbar上的所有子视图
//    NSArray *subViewArray = self.navigationController.navigationBar.subviews;
    //2.遍历子视图
//    for (UIView *tempView in self.navigationController.navigationBar.subviews) {
//        
//        NSLog(@"%@",tempView);
//        
//        if ([tempView isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
//            
//            for (UIView *temp in tempView.subviews) {
//                
//                NSLog(@"%@",temp);
//                
//                if ([temp isKindOfClass:[UIImageView class]]) {
//                    
//                    temp.hidden = YES;
//                }
//            }
//        }
//    }
 
    
    
}

#pragma mark ----布局视图-----------
//加载子视图
-(void)loadSubViews{
    //初始化自定义导航栏视图
    _customNaviBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size_width, 50)];
    [self.navigationController.navigationBar addSubview:_customNaviBarView];
    _customNaviBarView.backgroundColor = [UIColor colorWithWhite:1 alpha:0 ];
    //----------------添加定位按钮
    UIButton *locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    locationButton.frame = CGRectMake(0, 0, 80, 40);
    
    [_customNaviBarView addSubview:locationButton];
    
    [locationButton setTitle:@"未知" forState:UIControlStateNormal];
 
    [locationButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    [locationButton  setImage:[UIImage imageNamed:@"矩形-36@2x"] forState:UIControlStateNormal];
    //设置图片和title距离边界的位置
    [locationButton setImageEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
    [locationButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
    //给定位按钮添加一个点击事件
    [locationButton  addTarget:self action:@selector(handleLocationBtnAction:)  forControlEvents:UIControlEventTouchUpInside];
    locationButton.tag = kLocationBtn_Tag;
    //----------------创建搜索
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(CGRectGetMaxX(locationButton.frame) + 10, 5, size_width - 135, 30);
    [_customNaviBarView addSubview:searchButton];
    searchButton.layer.masksToBounds = YES;
    //设置弧度
    searchButton.layer.cornerRadius = 5;
    //添加一个白色的边框
    searchButton.layer.borderWidth = 0.5;
    searchButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [searchButton setTitle:@"景区/地区/关键字" forState:UIControlStateNormal];
    searchButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [searchButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    //设置标题距离左侧20
    [searchButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 120)];
    
    
    //----------------扫描
    UIButton *scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    scanButton.frame = CGRectMake(CGRectGetMaxX(searchButton.frame) + 5, 0, size_width - CGRectGetMaxX(searchButton.frame) - 10, 40);
    [scanButton setImage:[UIImage imageNamed:@"扫一扫-副本@2x-1"] forState:UIControlStateNormal];
    [_customNaviBarView addSubview:scanButton];
    
    self.tableView.tag = kTableView_Tag;
    //进来设置上面导航栏的下划线
    [self setNaviBar];
    
    
    //设置 自动布局的时候 出现 -----
    //automaticallyAdjustsScrollViewInsets 表示当前的界面是否自动适应scrollview的inset 设置成NO  可以自定义当前滚动视图上的子视图
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //隐藏navigationBar
//    self.navigationController.navigationBar.hidden = YES;
    
    //创建tableView的HeaderView
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size_width, kTableView_headerHeight)];
    headerView.backgroundColor = [UIColor redColor];
    //给tableView 添加自定义的headerView 
    self.tableView.tableHeaderView = headerView;

    
    //-------------三方添加轮播图-------------
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 20, size_width, 150) delegate:self placeholderImage:[UIImage imageNamed:@"banner3"]];
    //设置文字的标题
    _cycleScrollView.titlesGroup = @[@"第1页",@"第2页",@"第3页",];
    //设置文字的颜色
    _cycleScrollView.titleLabelTextColor = [UIColor yellowColor];
    //一张的时候 是否隐藏
    _cycleScrollView.hidesForSinglePage = YES;
    //设置labe背景颜色
    _cycleScrollView.titleLabelBackgroundColor = [UIColor clearColor];
    [headerView addSubview:_cycleScrollView];
    
    //-------------推荐旅游方式---------------
    NSArray *titleArray = [NSArray arrayWithObjects:@"旅游度假",@"目的地参团",@"邮轮",@"签证",@"门票",@"游学", nil];
    self.customView = [[LLCustomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_cycleScrollView.frame), size_width, 120) WithTitleArray:@[@"旅游度假",@"目的地参团",@"邮轮",@"签证",@"门票",@"游学"] imageArray:@[@"旅游度假",@"目的地参团",@"邮轮",@"签证",@"门票",@"游学"]];
    [headerView addSubview:self.customView];
    //点击相应按钮回调
    //实现防止循环引用的 弱引用的问题
    __weak typeof (self)weakSelf = self;
    _customView.buttonClick = ^(NSInteger index){
        NSLog(@"HomePage当前点击的按钮是%@",titleArray[index - 1000]);
     
        switch (index - 1000) {
            case 0:{
                LLTraelViewController *travelVC = [[LLTraelViewController alloc]init];
                //隐藏下面的属性
                travelVC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:travelVC animated:YES];
                
            }
                break;
                case 2:
            {
                //判断点击邮轮按钮 返回到邮轮界面
                LLShipViewController *shipVc = [[LLShipViewController alloc]init];
                //隐藏下面的属性
                shipVc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:shipVc animated:YES];
            }
                break;
            default:
                break;
        }
       
    };
    
    
    
    //-------------公告模块-----------------
    self.bannerView = [[LLBannerView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_customView.frame), size_width, 30) withAnnouncementDataArray:@[@"这是公告1"]];
    [headerView addSubview:self.bannerView];
    
    
    
    //--------------周边景点-和管家模块-----------------
    self.peripheralView = [[LLPeripheralFeatureSpotView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bannerView.frame) , size_width, 380) withDataArray:nil];
    [headerView addSubview:_peripheralView];
    //点击周边景点的buton
    __weak typeof (self)weakSelf3 = self;
    _peripheralView.peripheralButtonClicker = ^(NSInteger index){
        NSLog(@"周边景点被点了....");
        
        LLDetailTravelViewController *detailTraceVC = [[LLDetailTravelViewController alloc]init];
        LLPeripheraModel *model = weakSelf3.PerDataArray[index];
        detailTraceVC.DetailTitle =model.title;
         detailTraceVC.search_type = [NSString stringWithFormat:@"1"];
        detailTraceVC.route_type = @"-11";
        detailTraceVC.city_id = @"149";
        detailTraceVC.category_id = @"";
     
        //隐藏bar的属性
        detailTraceVC.hidesBottomBarWhenPushed = YES;
        [weakSelf3.navigationController pushViewController:detailTraceVC animated:YES];
    };
    
    //管家被点击的buton
    __weak typeof (self)weakSelf1 = self;
    _peripheralView.stewardButtonClicked = ^(NSInteger index){
        NSLog(@"管家被点击了......");
        LLStewardViewController *StewardView = [[LLStewardViewController alloc]init];
        [weakSelf1.navigationController pushViewController:StewardView animated:YES];
        
    };
    //更多被点击的button
    __weak typeof (self)weakSelf2 = self;
    _peripheralView.moreButtonClicker = ^(NSInteger index){
        NSLog(@"更多按钮被点击了....");
        LLMorePeripheralViewController *morePreripheralVC = [[LLMorePeripheralViewController alloc]init];
        //隐藏bar的属性
        morePreripheralVC.hidesBottomBarWhenPushed = YES;
        [weakSelf2.navigationController pushViewController:morePreripheralVC animated:YES];
        
    };
    
    
    
    //------------精选旅游目的地---------------------
    self.travelDestinationView = [[LLTravelDestinationView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_peripheralView.frame), size_width, 200) withDataDic:nil];
    [headerView addSubview:_travelDestinationView];
    
//    设置代理对象为当前的controller
    self.travelDestinationView.delegate = self;
    
  
    
    
}
#pragma mark -----点击首页城市定位按钮
-(void)handleLocationBtnAction:(UIButton *)sender{
    LLCityListViewController *CityListVC = [[LLCityListViewController alloc]init];
    
    CityListVC.currentCityStr = [sender titleForState:UIControlStateNormal];

    //------给模态的视图 添加根视图控制器
    UINavigationController *cityNavi = [[UINavigationController alloc]initWithRootViewController:CityListVC];
    
    [self.navigationController presentViewController:cityNavi animated:YES completion:nil];
}

#pragma mark-------AAA加载数据---------
//加载数据
-(void)loadData{
    //请求轮播图数据
    
    [LLNetWorkManage requestGetWithUrlStr:URL_CycleScrollView paramDict:nil finish:^(id responseObejct) {
        NSLog(@"请求成功.......%@",responseObejct);
        //
        NSArray *dataArray = [NSArray arrayWithArray:responseObejct];
        //存储轮播图片的路径
        NSMutableArray *srcArray = [NSMutableArray array];
        for (NSDictionary *dic in dataArray) {
            //创建轮播图的数据model
            LLCycleScrollViewDataModel *model = [[LLCycleScrollViewDataModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.cycleScrollviewDataArray addObject:model];
             NSLog(@"++++++++%@",self.cycleScrollviewDataArray);
            //轮播路径的拼接......
            NSString *src = [NSString stringWithFormat:@"%@%@",URL_Base,model.src];
            [srcArray addObject:src];
        }
        //更新轮播图 数据源
        _cycleScrollView.imageURLStringsGroup = srcArray;
       
    } enError:^(NSError *error) {
        NSLog(@"请求失败了.......%@",error);
    }];
    
    
    //----------公告栏--------------------
    [LLNetWorkManage requestGetWithUrlStr:URL_News paramDict:nil finish:^(id responseObejct) {
        //请求到数据
        NSArray *array = responseObejct[@"data"];
        NSMutableArray *dataArray = [NSMutableArray array];
            for (NSDictionary *dic in array) {
//                LLBannerModel *model = [[LLBannerModel alloc]init];
//                [model setValuesForKeysWithDictionary:dic];
//                [dataArray addObject:model];
                NSString *title = [dic valueForKey:@"title"];
                [dataArray addObject:title];


                
            }

        [self.bannerView UpdataWithArray:dataArray];
        
        
    } enError:^(NSError *error) {
        //请求失败
  
    }];
    
    
    
    //---------------周边景点------------
    NSDictionary *paramDic = @{@"city_id":@149,@"assistant":@0};
 
    [LLNetWorkManage requestPOSTWithUrlStr:URL_PeriPhera paramDict:paramDic finish:^(id responseObject) {
        NSDictionary *PerDict = [responseObject objectForKey:@"data"];
                NSArray *PerArray = [PerDict valueForKey:@"aroundScenicList"];
        
                for (NSDictionary *dict in PerArray) {
                    LLPeripheraModel *PerModel = [[LLPeripheraModel alloc]init];
        
                    [PerModel setValuesForKeysWithDictionary:dict];
        
                    [self.PerDataArray addObject:PerModel];
        
                    NSLog(@"pppppppp ===== %@",_PerDataArray);

    }
     [self.peripheralView UpDataButtonArray:_PerDataArray];
        
    } enError:^(NSError *error) {
        
        
    }];
    
    
    //------------精选旅游目的地-----------
    NSDictionary *TravelDic1 = @{@"city_id":@149,@"assistant":@0};
    [LLNetWorkManage requestPOSTWithUrlStr:URL_PeriPhera paramDict:TravelDic1 finish:^(id responseObject) {
        NSDictionary *TraveDict = [responseObject objectForKey:@"data"];
        NSArray *TraveArray = [TraveDict valueForKey:@"choiceDestList"];
        self.TraveDataArray = [NSMutableArray array];
        for (NSDictionary *dic in TraveArray) {
            LLPeripheraModel *TraveModel = [[LLPeripheraModel alloc]init];
            
            [TraveModel setValuesForKeysWithDictionary:dic];
            
            [self.TraveDataArray addObject:TraveModel];
            
//            NSLog(@"pppppppp ===== %@",self.TraveDataArray);
            [self.travelDestinationView UpDataButtonArray:self.TraveDataArray];
        }
        
    } enError:^(NSError *error) {
        
        
    }];
    
    //--------------游学门票邮轮---------------------
    //邮轮
     NSDictionary *paramDic1 = @{@"city_id":@149,@"assistant":@0};
   
    [LLNetWorkManage  requestPOSTWithUrlStr:URL_PeriPhera paramDict:paramDic1 finish:^(id responseObject) {
        NSDictionary *Dict = responseObject[@"data"];
        NSArray *array = [Dict valueForKey:@"productTabList"];
        NSDictionary *tempDict = array[0];
        NSArray *tempArray = [tempDict objectForKey:@"list"];
        
        
        for (NSDictionary *dic in tempArray) {
             [_tempDataArray removeAllObjects];
            LLShipModel *model = [[LLShipModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.shipDataArray addObject:model];
            [_tempDataArray addObjectsFromArray:self.shipDataArray];
            [self.tableView reloadData];
        }
        
        
       //-------------门票--------
       
        NSDictionary *tempDict1 = array[1];
        NSArray *tempArray1 = [tempDict1 objectForKey:@"list"];
        for (NSDictionary *dic1 in tempArray1) {
      
            [_tempDataArray removeAllObjects];
            LLTicketModel *model = [[LLTicketModel alloc]init];

            //  判断是否是数组-还是字符串
            if ([[[dic1 objectForKey:@"images"] objectForKey:@"image"] isKindOfClass:[NSArray class]]) {
                model.image = [[dic1 objectForKey:@"images"] objectForKey:@"image"][0];
//                NSLog(@"++++++%@",model.image);
            }else{
                model.image = [NSString stringWithFormat:@"%@",[[dic1 objectForKey:@"images"] objectForKey:@"image"]];
            }
            
            model.placeToAddr = [dic1[@"scenic_attach"] objectForKey:@"placeToAddr"];
            model.scenic_name = dic1[@"scenic_name"];
            model.start_price = dic1[@"start_price"];
            model.place_level = dic1[@"place_level"];
            model.openTime = dic1[@"openTime"];
            model.freePolicy = [dic1[@"bookingInfo"] objectForKey:@"freePolicy"];
            model.explanation =[dic1[@"bookingInfo"]objectForKey:@"explanation"];
            model.offerCrowd =[dic1[@"bookingInfo"]objectForKey:@"offerCrowd"];
            model.product_reminder = dic1[@"product_reminder"];
            model.playAttraction = dic1[@"playAttraction"];
            
            
            
//            [model setValuesForKeysWithDictionary:dic1];
            
            [self.ticketDataArray addObject:model];
            
//            [_tempDataArray addObjectsFromArray:_ticketDataArray];
            
//            [self.tableView reloadData];
        }
        NSLog(@"__________ --- %@",self.ticketDataArray);

        //----------------
        NSDictionary *temp2Dic = array[2];
         NSArray *tempArray2 = [temp2Dic objectForKey:@"list"];
        for (NSDictionary *tempDic2 in tempArray2) {
            LLStudyModel *model1 = [[LLStudyModel alloc]init];
            
            [model1 setValuesForKeysWithDictionary:tempDic2];
             NSLog(@"111111111%@",model1.thumb);
            [self.studyDataArray addObject:model1];
            NSLog(@"stu+++++++%@",_studyDataArray);
        }
        
    } enError:^(NSError *error) {
        
    }];
    
    
}
#pragma mark -------精选旅游目的地 回调-------
//点击更多按钮的时候 回调
-(void)moreButtonClicked{
    NSLog(@"点击了精选目的的更多按钮......");
    LLMoreTravelDestinationViewController *MoreTravelDestinationVC = [[LLMoreTravelDestinationViewController alloc]init];
    //隐藏Bar
    MoreTravelDestinationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:MoreTravelDestinationVC animated:YES];


}
//点击精选景点的按钮
-(void)sightSpotButtonClicked{
    NSLog(@"点击 了精选景点的按钮按钮的........");
    LLDetailTravelViewController *detailTraverVC = [[LLDetailTravelViewController alloc]init];
    LLPeripheraModel *Model = self.TraveDataArray[0];
    detailTraverVC.DetailTitle =Model.title;
    detailTraverVC.search_type = @"1";
    detailTraverVC.city_id = @"149";
    detailTraverVC.route_type = @"-11";
    detailTraverVC.category_id = @"";
    detailTraverVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:detailTraverVC animated:YES];
    
}

#pragma mark ------点击对应的视图跳转到对应的--------
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击的model是--------%ld",index);
    LLJSWebViewController *webView = [[LLJSWebViewController alloc]init];
    webView.Webmodel = [self.cycleScrollviewDataArray objectAtIndex:index];
    
    [self.navigationController pushViewController:webView animated:YES];
    self.navigationController.navigationBar.hidden  = NO;
}



#pragma mark   --邮轮游学门票点击-------------------  作为分区视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  
    return self.headrView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
#pragma mark ------------邮轮游学门票点击-----------
-(void)buttonClik:(NSInteger)tag{
    NSLog(@"%ld被点击了",tag);
    [_tempDataArray removeAllObjects];
     _index = tag;
    switch (tag) {
        case 111:
            [_tempDataArray addObjectsFromArray:self.shipDataArray];
            
            [self.tableView reloadData];
            break;
            case 222:
           
            [_tempDataArray addObjectsFromArray:self.ticketDataArray];
            [self.tableView reloadData];
            NSLog(@"!!!!!!! %@",_tempDataArray);
            break;
            case 333:
            [_tempDataArray addObjectsFromArray:self.studyDataArray];
            [self.tableView reloadData];
            break;
            
        default:
            break;
    }
    
}


#pragma mark ----- UITAbleViewDataSource && UITabelViewDelegate----
//返回tableView的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tempDataArray.count;
}

//返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LLShipCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
   
  
    if (_index == 111) {
        LLShipModel *model = self.tempDataArray[indexPath.row];
                    [cell setUpDataModel:model];
    }else if (_index == 222){
        LLTicketModel *TICmodel = self.tempDataArray[indexPath.row];
                    [cell setUpDataTicketModel:TICmodel];
    }else if(_index == 333){
        LLStudyModel *STUmodel = self.tempDataArray[indexPath.row];
        [cell setUpDataStudyModel:STUmodel];
    }
    
    
    
    return cell;
    
}

//点击邮轮 跳转到2级页面的邮轮详情
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_index == 111) {
        LLShipDetailViewController *shipDetailVC = [[LLShipDetailViewController alloc]init];
        LLShipModel *model = self.tempDataArray[indexPath.row];
        shipDetailVC.product_id = model.product_id;
        //隐藏下面的bar
        shipDetailVC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:shipDetailVC animated:YES];
    }else if (_index == 222){
        LLTicketViewController *TicketVC = [[LLTicketViewController alloc]init];
        LLTicketModel *model = self.tempDataArray[indexPath.row];
        TicketVC.model =model;
        //隐藏下面的bar
        TicketVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:TicketVC animated:YES];
        
    }
}

#pragma mark --------根据透明度 绘制图片--------
-(UIImage *)getImageWithAlpha:(CGFloat)alpha{
    //创建一个color的对象
    UIColor *color = [UIColor colorWithRed:1 green:1 blue:1 alpha:alpha];
    
    //创建一个绘制大小
    CGSize colorSize = CGSizeMake(1, 1);
    //开始绘制颜色区域
    UIGraphicsBeginImageContext(colorSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //根据提供的颜色给相应绘制的内容填充
    CGContextSetFillColorWithColor(context, color.CGColor);
    //设置填充相应的区域
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    
    //声明UIImage对象
    UIImage *img =UIGraphicsGetImageFromCurrentImageContext();
    //结束绘制
    UIGraphicsEndImageContext();
    return img;
    
    
}
#pragma mark -------ScrollViewDelegate
//
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag == kTableView_Tag) {
            //先获取当前tableView的滚动的偏移量
        CGFloat contentoffset_y = scrollView.contentOffset.y;
        //根据偏移量 动态计算alpha值
        CGFloat alpha = contentoffset_y / 100 > 1 ? 1 : contentoffset_y / 100;
        //根据alpha 绘制一张图片
        UIImage *newImg = [ self getImageWithAlpha:alpha];
        //将绘制的图片设置导航栏的背景图片
        [self.navigationController.navigationBar setBackgroundImage:newImg forBarMetrics:UIBarMetricsDefault];
        
        
        
    }
}



#pragma mark ----------定位
- (void)customLocation{
    // 创建定位管理者
    self.locationManager = [[CLLocationManager alloc] init];
    // 检查定位服务是否可用
    if (![CLLocationManager locationServicesEnabled]) {
        // 不可用直接跳出
        return;
    }

    // 如果没有授权
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        // 开启 -- 使用的时候可用
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    // 配置定位精度
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // 更新频率
    CLLocationDistance distance = 1000.0;// 1000米定位一下
    self.locationManager.distanceFilter = distance;
    
    // 代理
    self.locationManager.delegate = self;
    // 启动定位
    [self.locationManager startUpdatingLocation];

}



#pragma mark - CLLocationManagerDelegate的代理方法 -
// 1. 每次定位都会执行, 多次执行的方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    // 最新的位置总是存放在第一位
    CLLocation *location = locations.firstObject;
    
     NSLog(@"维度: %f, 经度: %f", location.coordinate.latitude, location.coordinate.longitude);
    
    [self getAddressWithLatitude:location.coordinate.latitude withLongitude:location.coordinate.longitude];
//    [self getAddressWithLatitude:34.823 withLongitude:113.556];
    
}


// 2. 定位失败的时候会执行的方法
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"_-----------------%@-",error);
}

#pragma mark - 地理反编码 -
- (void)getAddressWithLatitude: (CLLocationDegrees )latitude withLongitude: (CLLocationDegrees )longitude{
    // 反编码
    // 通过经度封装一个location对象
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *mark = [placemarks firstObject];
        NSLog(@"+++++________%@",mark);
        
        NSString *titleString = [mark.addressDictionary objectForKey:@"City"];
        if (titleString.length > 0) {
            titleString = [titleString substringToIndex:titleString.length - 1];
        }
        
         NSLog(@"++++++#########%@",titleString);
        //更新定位按钮的title值
        UIButton *locationBtn = [_customNaviBarView viewWithTag:kLocationBtn_Tag];
        [locationBtn setTitle:titleString forState:UIControlStateNormal];
        LLCityListViewController *CityListVC = [[LLCityListViewController alloc]init];
        CityListVC.mySelectItemBlock =^(NSString *str,NSString *product_id) {
            //更新定位按钮的title值
            UIButton *locationBtn = [_customNaviBarView viewWithTag:kLocationBtn_Tag];
            [locationBtn setTitle:str forState:UIControlStateNormal];
            
            
        };
        
    }];
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
