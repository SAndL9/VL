//
//  LLDetailLineViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/12.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLDetailLineViewController.h"
#import "LLShipCell.h"
#import "LLNetWorkManage.h"
#import "LLShipModel.h"
@interface LLDetailLineViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UISearchBar *searchBar;

//数据源
@property(nonatomic,strong)NSMutableArray *detailLineDataArray;


@end
static NSString *detailLine = @"cellid";
@implementation LLDetailLineViewController

-(NSMutableArray *)detailLineDataArray{
    if (!_detailLineDataArray) {
        self.detailLineDataArray = [NSMutableArray array];
    }
    return _detailLineDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadData];
    [self loadSubVies];
}

#pragma mark ------
-(void)loadSubVies{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64 + 45, size_width, size_height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[LLShipCell class] forCellReuseIdentifier:detailLine];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 100;
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, size_width, 40)];
    [self.view addSubview:_searchBar];
    
}
#pragma mark ------
-(void)loadData{
//    NSLog(@"*****&@!@@@@#@##@#------%@",_DetailLine);
//    NSDictionary *paramDict1 = @{@"city_id":_DetailCity_id,@"line":_DetailLine,@"assistant_id":_DetailAssistant_id};
//    [LLNetWorkManage requestPOSTWithUrlStr:URL_DetailLine paramDict:paramDict1 finish:^(id responseObject) {
//        NSMutableArray *returnArray = responseObject[@"data"];
//        NSLog(@"detailLine------------%ld",returnArray.count);
//        for (NSDictionary *dic in returnArray) {
//            LLShipModel *model = [[LLShipModel alloc]init];
//            [model setValuesForKeysWithDictionary:dic];
//            [self.detailLineDataArray addObject:model];
//            NSLog(@"****&*&*&*&*&*&%@",self.detailLineDataArray);
//        }
//        [self.tableView  reloadData];
//        
//    } enError:^(NSError *error) {
//        
//        
//    }];
    
     NSString *urlSt = [NSString stringWithFormat:@"%@?city_id=%@&line=%@&sort=&dir=&page=1&pagesize=10&assistant_id=%@", URL_DetailLine, _DetailCity_id, _DetailLine,_DetailAssistant_id];
    [LLNetWorkManage requestGetWithUrlStr:urlSt paramDict:nil finish:^(id responseObejct) {
        

        NSMutableArray *returnArray = responseObejct[@"data"];
        NSLog(@"detailLine------------%ld",returnArray.count);
        for (NSDictionary *dic in returnArray) {
            LLShipModel *model = [[LLShipModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.detailLineDataArray addObject:model];
            NSLog(@"****&*&*&*&*&*&%@",self.detailLineDataArray);
        }
        [self.tableView  reloadData];

        
    } enError:^(NSError *error) {
        
        
    }];
    
}

#pragma mark ---- 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailLineDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLShipCell *cell = [tableView dequeueReusableCellWithIdentifier:detailLine ];
    NSLog(@"kkkkk-------%@",self.detailLineDataArray[indexPath.row]);
    LLShipModel *model = self.detailLineDataArray[indexPath.row];
    [cell setUpDataModel:model];
    
    return cell;
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
