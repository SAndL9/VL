//
//  LLDetailTravelViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/8.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLDetailTravelViewController.h"
#import "LLDetailTravelViewModel.h"
#import "LLNetWorkManage.h"
#import "LLDetailTravelViewCell.h"
#import "LLCustomButton.h"
@interface LLDetailTravelViewController () <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

//数据源
@property(nonatomic,strong)NSMutableArray *detailTraverArray;

//第一个button的数据源


@end

static NSString *cellid = @"LLDetailTravelViewCell";

@implementation LLDetailTravelViewController

-(NSMutableArray *)detailTraverArray{
    if (!_detailTraverArray) {
        self.detailTraverArray = [NSMutableArray array];
    }
    return _detailTraverArray;
}

-(void)viewWillAppear:(BOOL)animated{
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = YES;
//    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"detailtitle ==== %@",_DetailTitle);
    self.navigationItem.title = _DetailTitle;
    [self loadData];
    [self loadSubViews];
    
}
-(void)loadSubViews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, size_width, size_height - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //注册cell
    [self.tableView registerClass:[LLDetailTravelViewCell class] forCellReuseIdentifier:cellid];

  
    
    
    
    
    
}

-(void)loadData{
    if ([_DetailTitle isEqualToString:@"云南"]) {
        _DetailTitle = @"昆明";
    }
    
    NSDictionary *paramDic = @{@"city_id":_city_id,@"offset":@1,@"title":_DetailTitle,@"search_type":_search_type,@"route_type":_route_type,@"category_id":_category_id};
    [LLNetWorkManage requestPOSTWithUrlStr:URL_DetailTravel paramDict:paramDic finish:^(id responseObject) {
        if (responseObject[@"status"] == 0  ) {
            NSLog(@"没钱去港澳台......");
        }
        
        
        NSArray *returnArr = responseObject[@"data"];

        NSLog(@"**)*********------%@",returnArr);

       
        //        if (returnArr == nil ) {
//            return NSLog(@"结束了。。。。。");
//        }
        for (NSDictionary *dic in returnArr) {
            LLDetailTravelViewModel *model = [[LLDetailTravelViewModel alloc]init];
            if ([[dic objectForKey:@"wl_tags"]isKindOfClass:[NSArray class]]) {
                for (NSDictionary *tempDic in [dic objectForKey:@"wl_tags"]) {
                    model.tag_name = [tempDic objectForKey:@"tag_name"];
                }
            }
            if ([[dic objectForKey:@"timetables"]isKindOfClass:[NSArray class]]) {
                for (NSDictionary *tempDic in [dic objectForKey:@"timetables"] ) {
                    model.date_time = [tempDic objectForKey:@"date_time"];
                }
            }

            
            [model setValuesForKeysWithDictionary:dic];
            [self.detailTraverArray addObject:model];
            NSLog(@"%@------%@",model.date_time,model.tag_name);
        }
       
        NSLog(@"kkk=========%@",self.detailTraverArray);
        [self.tableView reloadData];
    } enError:^(NSError *error) {
    
        
    }];
    
  
}

#pragma mark -----UITableViewDataSource-----
//返回多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _detailTraverArray.count;
}
//返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath   {
    LLDetailTravelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
  
    LLDetailTravelViewModel *model = self.detailTraverArray[indexPath.row];
    [cell setUpCellWithModel:model];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
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
