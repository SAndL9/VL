//
//  LLTraelViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/9.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLTraelViewController.h"
#import "LLNetWorkManage.h"
#import "LLTravelCell.h"
#import "LLTravelModel.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "LLDetailTravelViewController.h"
#import "LLCustomButton.h"
#import "LLPeripheraModel.h"
#import "LLTravelDetailViewController.h"


@interface LLTraelViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
//数据源
@property(nonatomic,strong)NSMutableArray *TraelDataArray;
//轮播图数据源
@property(nonatomic,strong)NSMutableArray *cycyleDataArray;

//上面的5个按钮
@property(nonatomic,strong)LLCustomButton *customButton;
//下面3个大的按钮
@property(nonatomic,strong)LLCustomButton *BigCustomButton;


@end

static NSString *traelCellID = @"TarvelCell";
@implementation LLTraelViewController

-(NSMutableArray *)TraelDataArray{
    if (!_TraelDataArray) {
        self.TraelDataArray = [NSMutableArray array];
    }
    return _TraelDataArray;
}

-(NSMutableArray *)cycyleDataArray{
    if (!_cycyleDataArray) {
        self.cycyleDataArray = [NSMutableArray array];
    }
    return _cycyleDataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    
   
}

#pragma mark -----------
-(void)loadSubViews{
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"旅游";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, size_width, size_height - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size_width, 515)];
//    headView.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = headView;
    [self.tableView registerClass:[LLTravelCell class] forCellReuseIdentifier:traelCellID];
    
    
    //取出加载轮播图的图片路径
    NSMutableArray *picUrl = [NSMutableArray array];
    for (LLPeripheraModel  *model in self.cycyleDataArray) {
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",URL_Base,model.src];
        [picUrl addObject:urlStr];
    }
    
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, size_width, 150) imageURLStringsGroup:picUrl];
//    cycleScrollView.backgroundColor = [UIColor yellowColor];
    cycleScrollView.delegate = self;
    [headView addSubview:cycleScrollView];
    
    //-----------------中间5个button添加点击事件---------
    NSArray *titleArr = @[@"周边游",@"国内游",@"港澳台",@"出境游",@"境外参团"];
    NSArray *imageArr = @[@"travle_around_image@2x",@"travle_inland_image@2x",@"travle_HKMacaoTW_image@2x",@"travle_bound_image@2x",@"travle_outboundgroup_image@2x"];
    for (int i = 0; i < 5; i++) {
        CGFloat width = (size_width - 6 * 15 ) / 5;
        self.customButton = [[LLCustomButton alloc]initWithFrame:CGRectMake(15 + (15 + width)* i , CGRectGetMaxY(cycleScrollView.frame) + 10, width, 60) title:titleArr[i] imageName:imageArr[i]];
        self.customButton.backgroundColor    = [UIColor  whiteColor];
        [self.customButton addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.customButton setTag:100000 + i];
        [headView addSubview:self.customButton];
    }
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_customButton.frame) + 35, size_width, 15)];
    view.backgroundColor = [UIColor grayColor];
    [headView addSubview:view];
    
        //---------预留文字的
    
    //------------------3个button的布局 和 点击实现
    NSArray *BigImageArr = @[@"travle_gift_image@2x",@"travle_mountain_image@2x",@"travle_holiday_image@2x"];
    for (int i = 0; i < 3; i++) {
        CGFloat Width = (size_width - 10 * 4 ) / 3 ;
        self.BigCustomButton = [[LLCustomButton alloc]initWithFrame:CGRectMake(10 + (Width +10) * i, CGRectGetMaxY(view.frame) + 70, Width, 120) title:nil imageName:BigImageArr[i]];
        [_BigCustomButton addTarget:self action:@selector(BigButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _BigCustomButton.backgroundColor = [UIColor redColor];
        [_BigCustomButton setTag:200000 + i];
        if (i < 2) {
            UIView *lineView = [[UIView  alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 2, 0, 2, self.view.frame.size.height)];
            lineView.backgroundColor = [UIColor orangeColor];
            [_BigCustomButton addSubview:lineView];
        }
        
        
        [headView addSubview:_BigCustomButton];
        NSLog(@"--------%f",CGRectGetMaxY(_BigCustomButton.frame));
    }
    
    UIView *BottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_BigCustomButton.frame), size_width, 15)];
    BottomView.backgroundColor = [UIColor grayColor];
    [headView addSubview:BottomView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(BottomView.frame), size_width, 40)];
    titleLab.text = @"精品航线";
    [headView addSubview:titleLab];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //-----------足尾-------
   UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size_width, 45)];
    footerView.backgroundColor = [UIColor orangeColor];
    self.tableView.tableFooterView = footerView;
    footerView.userInteractionEnabled = YES;
    UIButton  *footerMoreBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, size_width, 45)];
    [footerMoreBtn setTitle:@"点击加载更多" forState:UIControlStateNormal];
    [footerMoreBtn addTarget:self action:@selector(MoreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:footerMoreBtn];
}

#pragma mark ------点击buttou
-(void)ButtonClick:(UIButton *)sender{
    NSLog(@"点击的是 %ld",sender.tag);
    switch (sender.tag - 100000) {
        case 0:
            
        {
            LLDetailTravelViewController *vc = [[LLDetailTravelViewController alloc]init];
            vc.DetailTitle = @"";
            vc.search_type = @"";
            vc.city_id = @"149";
            vc.route_type = @"-11";
            vc.category_id = @"";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 1:
            
        {
            LLDetailTravelViewController *vc = [[LLDetailTravelViewController alloc]init];
            vc.DetailTitle = @"";
            vc.search_type = @"";
            vc.city_id = @"149";
            vc.route_type = @"-12";
            vc.category_id = @"";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
            
        {
            LLDetailTravelViewController *vc = [[LLDetailTravelViewController alloc]init];
            vc.DetailTitle = @"";
            vc.search_type = @"";
            vc.city_id = @"149";
            vc.route_type = @"-14";
            vc.category_id = @"";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
            
        {
            LLDetailTravelViewController *vc = [[LLDetailTravelViewController alloc]init];
            vc.DetailTitle = @"";
            vc.search_type = @"";
            vc.city_id = @"149";
            vc.route_type = @"-13";
            vc.category_id = @"";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
            
        {
            LLDetailTravelViewController *vc = [[LLDetailTravelViewController alloc]init];
            vc.DetailTitle = @"";
            vc.search_type = @"";
            vc.city_id = @"149";
            vc.route_type = @"-15";
            vc.category_id = @"";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }

    
}
-(void)BigButtonClick:(UIButton *)sender{
    NSLog(@"大图点击的是%ld",sender.tag);
    switch (sender.tag - 200000) {
        case 0:
        {
            LLDetailTravelViewController *vc = [[LLDetailTravelViewController alloc]init];
            vc.DetailTitle = @"";
            vc.search_type = @"";
            vc.city_id = @"149";
            vc.route_type = @"-11";
                vc.category_id = @"";
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
        case 1:
        {
            LLDetailTravelViewController *vc = [[LLDetailTravelViewController alloc]init];
            vc.DetailTitle = @"踏青-山";
            vc.search_type = @"1";
            vc.city_id = @"149";
            vc.route_type = @"-11";
                vc.category_id = @"";
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            
            break;
        case 2:
        {
            LLDetailTravelViewController *vc = [[LLDetailTravelViewController alloc]init];
            vc.search_type = @"1";
            vc.city_id = @"149";
            vc.route_type = @"-11";
            vc.DetailTitle=@"";
                vc.category_id = @"60";
            [self.navigationController pushViewController:vc animated:YES];

        }
            
            break;
            
        default:
            break;
    }
}
#pragma mark ------点击加载更多Button
-(void)MoreBtnClick:(UIButton *)sender{
    NSLog(@"旅游页面的更多按钮被点击了........");
   }



#pragma mark ----------
-(void)loadData{
    NSDictionary *paramDIc = @{@"city_id":@149};
    [LLNetWorkManage requestPOSTWithUrlStr:URL_Travel paramDict:paramDIc finish:^(id responseObject) {
        NSLog(@"#!@#!#!$------- %@",responseObject);
        
        NSDictionary *returnDic = responseObject[@"data"];
        NSArray *returnArray = [returnDic objectForKey:@"index_ads"];
        for (NSDictionary *dic in returnArray) {

            LLPeripheraModel *model = [[LLPeripheraModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.cycyleDataArray addObject:model];
            
        }
        NSLog(@"******!!!!!%@",self.cycyleDataArray);
       //-------------------
        
        for (NSDictionary *dic in [returnDic objectForKey:@"jp_products"]) {
            LLTravelModel *model = [[LLTravelModel alloc]init];
         
            [model setValuesForKeysWithDictionary:dic];
            
            [self.TraelDataArray  addObject:model];
        }
       
        
        
        [self loadSubViews];
   
        
         [self.tableView reloadData];
    } enError:^(NSError *error) {
        
        
    }];
    
   
}

#pragma mark ------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.TraelDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LLTravelCell *cell = [tableView dequeueReusableCellWithIdentifier:traelCellID forIndexPath:indexPath];
    LLTravelModel *model = self.TraelDataArray[indexPath.row];
    [cell setUpCellWithModel:model];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath   {
    return 320;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSIndexPath *index = tableView.indexPathForSelectedRow;
    LLTravelModel *model = self.TraelDataArray[indexPath.row];
    NSLog(@"选择的是......%@",model.product_name);
    
    LLTravelDetailViewController *detailVC = [[LLTravelDetailViewController alloc]init];
    detailVC.pid = model.product_id;
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
}


#pragma mark --------CycleScrollViewDelegate------
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击的是.....%ld",index);
    LLDetailTravelViewController  *detailTravelVC = [[LLDetailTravelViewController alloc]init];
    LLPeripheraModel *model =self.cycyleDataArray[index];
    detailTravelVC.DetailTitle =model.title;
    detailTravelVC.search_type = @"1";
    detailTravelVC.city_id = @"149";
    detailTravelVC.route_type = @"-11";
      detailTravelVC.category_id = @"";
    [self.navigationController pushViewController:detailTravelVC animated:YES];
    
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
