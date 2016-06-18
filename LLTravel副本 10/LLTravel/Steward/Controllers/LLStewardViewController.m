//
//  LLStewardViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/2.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLStewardViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "LLStewardViewCell.h"

#import "LLNetWorkManage.h"
#import "LLStewardListModel.h"

#import "StewardListCell.h"
#import "MJRefresh.h"

#import "LLStewardDetailViewController.h"

static NSString *headerID = @"header";
static NSString *cellID = @"cellid";
@interface LLStewardViewController () <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIView *backView;//展开筛选视图
@property(nonatomic,assign)BOOL flag; //标识筛选视图是否出现，yes出现

@property(nonatomic,strong)NSMutableArray *listDataArray; //存放管家的数据

@property(nonatomic,copy)NSString *order_count;//案例参数asc表示升序排列 desc 表示降序

@property(nonatomic,copy)NSString *level; //评分参数  asc表示升序  desc表示降序

@property(nonatomic,copy)NSString *gender; //性别 1表示男 2表示女  不传表示全部

@property(nonatomic,strong)NSMutableDictionary  *paramDic; //动态参数字典


@property(nonatomic,assign)BOOL isUp; //YES:上拉  NO下拉

@end

@implementation LLStewardViewController
-(NSMutableDictionary *)paramDic{
    if (!_paramDic) {
        self.paramDic = [NSMutableDictionary dictionary];
    }
    return _paramDic;
}

-(NSMutableArray *)listDataArray{
    if (!_listDataArray) {
        self.listDataArray = [NSMutableArray array];
    }
    return _listDataArray;
}

//创建弹出视图
-(UIView *)backView{
    if (!_backView) {
        self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, size_width, size_height)];
        _backView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
        //创建3个button
        for (int i = 0; i < 3; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 40 * i, size_width, 40);
            [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            button.layer.borderWidth = 0.5;
            button.backgroundColor = [UIColor whiteColor];
            button.layer.borderColor = [UIColor darkGrayColor].CGColor;
            [button addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [button setTag:100+i];
            switch (i) {
                case 0:
                    [button setTitle:@"全部" forState:(UIControlStateNormal)];
                    break;
                case 1:
                    [button setTitle:@"男" forState:(UIControlStateNormal)];
                    break;
                case 2:
                    [button setTitle:@"女" forState:(UIControlStateNormal)];
                    break;
                default:
                    break;
            }
            [_backView addSubview:button];
            [self.view addSubview:_backView];
        }
    }
    return _backView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBarButtonClick:)];
    //设置导航栏上的按钮颜色
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    
    [self loadCurrentSubViews];
    [self loadData];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    

    
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"StewardListCell" bundle:nil] forCellReuseIdentifier:@"StewardListCell"];
    
    //预算tableViewCell的高度
    self.tableView.estimatedRowHeight = 120;
    //自动适应高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    self.flag = NO;
    
    
    [self addRefresh];
    
    [self.tableView.mj_header   beginRefreshing];
}
//添加上拉加载和下拉刷新
-(void)addRefresh{
    //添加下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self.tableView.mj_header endRefreshing];
        //下拉刷新的时候,将请求的offset改为0
        [self.paramDic setObject:@"0" forKey:@"offset"];
        [self requestDataList];
        _isUp = NO; //标识下拉
    }];
    
    //添加上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
//        [self.tableView.mj_footer endRefreshing];
        //上拉加载时 将当前请求的页数+1
        NSInteger offset = [[self.paramDic objectForKey:@"offset"] integerValue];
        offset++;
        [self.paramDic setObject:[NSString stringWithFormat:@"%ld",offset] forKey:@"offset"];
        [self requestDataList];
        _isUp = YES; //
    } ];
}


-(void)loadCurrentSubViews{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, size_width, size_height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    //------------------轮播图--------------
    SDCycleScrollView *sdcyclescrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, size_width, 150) imageNamesGroup:@[@"banner1",@"banner2",@"banner3"]];
    self.tableView.tableHeaderView = sdcyclescrollView;
    
    //---------------自定义cell-------------------
    
}
//网络请求数据
-(void)loadData{
    //请求管家列表
    NSDictionary *ParamDic = @{@"region_id":@"149",@"offset":@"0",@"limit":@"10"};
    self.paramDic = [NSMutableDictionary dictionaryWithDictionary:ParamDic];
    //调用方法
    [self requestDataList];
    
    //---------------------
    
    
}
//请求管家列表数据
-(void)requestDataList{
    
    [LLNetWorkManage requestPOSTWithUrlStr:URL_StewardList paramDict:self.paramDic finish:^(id responseObject) {
        [self.listDataArray removeAllObjects];
        //请求数据成功
        NSLog(@"请求列表成功%@",responseObject);
        //接收管家列表数据
        NSDictionary *returnDataDic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray *dataArray = [returnDataDic objectForKey:@"data"];
        if (!_isUp) {
            //清空之前的数据
            [self.listDataArray removeAllObjects];
        }
        
        //将存储转换成modle对象
        for (NSDictionary *dic in dataArray) {
           LLStewardListModel  *model = [[LLStewardListModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.listDataArray addObject:model];
            
        }
        
        NSLog(@"&&&&&&&&&------%@",self.listDataArray);
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } enError:^(NSError *error) {
        //请求数据失败
        NSLog(@"请求失败%@",error);
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
    
}


-(void)searchBarButtonClick:(UIBarButtonItem *)sender{
    NSLog(@"搜索被点击了......");
}

#pragma mark ------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listDataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StewardListCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"StewardListCell" forIndexPath:indexPath];
    //
    LLStewardListModel *model = self.listDataArray[indexPath.row];
    [cell setupDataWith:model];
    
    
    
    return cell;
}

//分区头
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return [self setupSectionHeaderView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

#pragma mark --- 分割线 顶头显示
//view布局完子控件的时候调用
- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
//cell即将展示的时候调用
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark - 添加SectionHeaderView
- (UIView *)setupSectionHeaderView {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,size_width, 40)];
    headerView.backgroundColor = [UIColor redColor];
    headerView.userInteractionEnabled = YES;
    CGFloat width = (headerView.frame.size.width - 10 * 2 - 5 * 2 ) / 3;
    
    UIButton *CaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [CaseButton setTitle:@"案例" forState:UIControlStateNormal];
    CaseButton.frame = CGRectMake(5, 5, width, 30);
    [CaseButton addTarget:self action:@selector(buttonclickAction:) forControlEvents:UIControlEventTouchUpInside];
    [CaseButton setTag:666];
    [headerView addSubview:CaseButton];
 
    UIButton *ScoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ScoreButton setTitle:@"评分" forState:UIControlStateNormal];
    ScoreButton.frame = CGRectMake(width + 5 + 10, 5, width, 30);
    [ScoreButton addTarget:self action:@selector(buttonclickAction:) forControlEvents:UIControlEventTouchUpInside];
    [ScoreButton addTarget:self action:@selector(buttonclickAction:) forControlEvents:UIControlEventTouchUpInside];
    [ScoreButton setTag:777];
    
    [headerView addSubview:ScoreButton];
    
    
    UIButton *selectButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [selectButton setTitle:@"全部" forState:(UIControlStateNormal)];
    [selectButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    selectButton.frame  = CGRectMake(2*width + 5 + 10 * 2, 5, width, 30);
    [selectButton addTarget:self action:@selector(clickedTheSelectButton:) forControlEvents:(UIControlEventTouchUpInside)];
    selectButton.layer.masksToBounds = YES;
    selectButton.layer.borderColor = [UIColor whiteColor].CGColor;
    selectButton.layer.borderWidth = 2;
    selectButton.tag = 888;
    [headerView addSubview:selectButton];
    return headerView;
}

-(void)buttonclickAction:(UIButton *)sender{
    switch (sender.tag) {
        case 666:
        {
                            NSLog(@"案例被点击了。。。。。。。");
//                            判断当前的案例参数如果是空 或者是desc 我们赋值为当前案例参数为asc
                            if (!self.order_count || [self.order_count isEqualToString:@"desc"]) {
                                self.order_count = @"asc";
                            }else{
                                self.order_count = @"desc";
                            }
                            NSString *order_count = [self.paramDic objectForKey:@"order_count"];
                            if (!order_count || [order_count isEqualToString:@"desc"]) {
                                order_count = @"asc";
                            }else{
                                order_count = @"desc";
                            }
                            [self.paramDic setObject:order_count forKey:self.order_count];
                            //调用网络请求
                            [self requestDataList];
            
                            }
            [self.tableView reloadData];
            
            break;
            case 777:
            //判断 进行筛选
                            {
                            //判断当前的评分参数 是否为空 或者desc  给参数赋值asc 否则赋值desc
                            if (!self.level || [self.level isEqualToString:@"desc"]) {
                                self.level= @"asc";
                            }else{
                                self.level = @"desc";
                            }
                            NSString *lever = [self.paramDic objectForKey:@"lever"];
                            if (!lever || [self.level isEqualToString:@"desc"]) {
                                lever = @"asc";
                            }else{
                                lever = @"desc";
                            }
                            [self.paramDic setObject:lever forKey:self.level];
                            //调用网络请求
                            [self requestDataList];
                              
                            }

            break;
            
        default:
            break;
    }
}
//点击筛选按钮
- (void)clickedTheSelectButton:(UIButton *)sender {
    //获得头视图在当前tableView中的位置
    CGRect rectInTableView = [self.tableView rectForHeaderInSection:0];
  
    //转化左边系统为tableView的父视图
    CGRect rectInSuperview = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
    //判断当rectInSuperview.origin.y<=64时，这时sectionHeader悬停，不再取相对位置
    if (rectInSuperview.origin.y<=64) {
        rectInSuperview = CGRectMake(rectInSuperview.origin.x, 64, rectInSuperview.size.width, rectInSuperview.size.height);
    }

    
    if (!self.flag) {
        //设置backView的frame
        self.backView.frame = CGRectMake(0, rectInSuperview.origin.y + rectInSuperview.size.height, self.backView.frame.size.width, 0);
        //弹出视图
        [UIView animateWithDuration:0.2 animations:^{
            self.backView.frame = CGRectMake(0, self.backView.frame.origin.y, size_width, size_height);
        }];
    }else {
        //收回视图
        [self returnTheBackView];
    }
    self.flag = !self.flag;
}

#pragma mark - 点击Button响应方法
- (void)handleButtonAction:(UIButton *)sender {
    NSString *titleStr;
    [self.paramDic removeObjectForKey:@"lever"];
    [self.paramDic removeObjectForKey:@"order_count"];
    
    switch (sender.tag) {
        case 100:
        {
            NSLog(@"全部");
            titleStr = @"全部";
            self.gender = nil;
            //移除所有案例和评分性别
            [self.paramDic removeObjectForKey:@"gender"];
        }
            break;
        case 101:
            NSLog(@"男");
            titleStr = @"男";
            self.gender = @"1";
            [self.paramDic setObject:@"1" forKey:@"gender"];
          
            break;
        case 102:
            NSLog(@"女");
            titleStr = @"女";
            self.gender = @"2";
            [self.paramDic setObject:@"2" forKey:@"gender"];
            break;
        default:
            break;
    }
    
    //根据性别请求数据
    [self requestDataList];
    [self returnTheBackView]; //回收视图
    //更新HeaderSection上Button的显示
    UIButton *selectButton = [self.view viewWithTag:888];
    [selectButton setTitle:titleStr forState:(UIControlStateNormal)];
    self.flag  = NO;
}

//收回筛选视图方法
- (void)returnTheBackView {
    for (UIButton *button in self.backView.subviews) {
        [button removeFromSuperview];
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.backView.frame = CGRectMake(0, self.backView.frame.origin.y, size_width, 0);
    }];
    self.backView = nil;
}

#pragma mark --------------UITableViewDelegate- UITableViewDataSource------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LLStewardDetailViewController *stewardDetailVC = [[LLStewardDetailViewController alloc]init];
    NSIndexPath *index  = tableView.indexPathForSelectedRow;
    stewardDetailVC.setDetailModel = _listDataArray[index.row];
    
    
    [self.navigationController pushViewController:stewardDetailVC animated:YES];
    
    
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
