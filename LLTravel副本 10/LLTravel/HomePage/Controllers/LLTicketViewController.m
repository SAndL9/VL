//
//  LLTicketViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/15.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLTicketViewController.h"
#import "LLTicketHeadView.h"
#import "LLTicketCell.h"
#import "UIImageView+WebCaChe.h"
#import "LLTicketSelect.h"
#import "LLReserveCell.h"
#import "LLTicketDetailModel.h"
#import "LLTicketDetailCell.h"
#define kReserveBtn_Tag 1101101
#define kScenicBtn_Tag 1101102

@interface LLTicketViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *ticketDataArray;//数据源

@property(nonatomic,assign)BOOL isReserve;//设置 是否属于选中状态 默认yes 为预定须知

@end


@implementation LLTicketViewController

-(UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, size_width, size_height-64) style:UITableViewStylePlain];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.ticketDataArray = [NSMutableArray array];
    // Do any additional setup after loading the view from its nib.
    [self loadData];
    [self loadSubViews];
}
#pragma mark -----
-(void)loadSubViews{
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    _isReserve = YES;
    

    LLTicketHeadView *TicketHeadView = [[LLTicketHeadView alloc]initWithFrame:CGRectMake(0, 0, size_width, 258)];
    self.tableView.tableHeaderView = TicketHeadView;
    [TicketHeadView.backImageView sd_setImageWithURL:[NSURL URLWithString:self.model.image] placeholderImage:[UIImage imageNamed:@"banner1"]];
    TicketHeadView.nameLab.text = self.model.scenic_name;
    TicketHeadView.ScenicLab.text = self.model.placeToAddr;
    TicketHeadView.priceLab.text = self.model.start_price;
    NSLog(@"opentime.........%@",self.model.openTime);
//    TicketHeadView.openTimeLab.text = self.model.openTime;
//    把标签字符串 转换成字符串
    NSAttributedString *attribuSr = [[NSAttributedString alloc]initWithData:[self.model.openTime dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    TicketHeadView.openTimeLab.attributedText = attribuSr;
    //去掉cell的lab上的换行
    NSString *tempStr = TicketHeadView.openTimeLab.text;
    tempStr = [tempStr stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    TicketHeadView.openTimeLab.text = tempStr;

    
    
    
    
    
    
    //注册成人和儿童cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LLTicketCell" bundle:nil] forCellReuseIdentifier:@"LLTicketCell"];
    //注册详情cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LLReserveCell" bundle:nil] forCellReuseIdentifier:@"LLReserveCell"];
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    //注册详情页面
    [self.tableView registerNib:[UINib nibWithNibName:@"LLTicketDetailCell" bundle:nil] forCellReuseIdentifier:@"LLTicketDetailCell"];

//    self.tableView.rowHeight = 100;
    //设置自适应
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    

    
    
}
#pragma mark ---
-(void)loadData{
    NSLog(@"++++++++!!!!!!!!!!%@",self.model.playAttraction);
    for (NSDictionary *tempDic in self.model.playAttraction) {
        LLTicketDetailModel *model = [[LLTicketDetailModel alloc]init];
        model.playName = tempDic[@"playName"];
        model.playInfo = tempDic[@"playInfo"];
        model.url = [tempDic[@"playImages"] objectForKey:@"url"];
        
        [self.ticketDataArray   addObject:model];
    }
    NSLog(@"-------------````%@",self.ticketDataArray);
    [self.tableView reloadData];
    
}
#pragma mark ---
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LLTicketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLTicketCell" forIndexPath:indexPath];
        return cell;
    }else if(indexPath.section == 1 ){
        if (_isReserve) {
            LLReserveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLReserveCell" forIndexPath:indexPath];
            cell.freePolicyLab.text = self.model.freePolicy;
            cell.explanationLab.text = self.model.explanation;
            cell.offerCrowdLab.text = self.model.offerCrowd;
            cell.contentLab.text = self.model.product_reminder;
            return cell;
        }else{
            LLTicketDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLTicketDetailCell" forIndexPath:indexPath];
            LLTicketDetailModel *model = self.ticketDataArray[indexPath.row];
            cell.playNameLab.text =model.playName;
            cell.playInfoLab.text = model.playInfo;
            [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@"6"]];
            return cell;
        }
    }
    return [[UITableViewCell alloc]init];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    if (section == 0) {
        return 2;
    }else if (section == 1){
        if (_isReserve) {
            return 1;
        }else{
            return _ticketDataArray.count;
        }
    }
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        LLTicketSelect *ticketVC = [[LLTicketSelect alloc]init];
//        ticketVC.tag = kReserveBtn_Tag;
        ticketVC.buttonClick = ^(NSInteger index){
            switch (index) {
                case kReserveBtn_Tag:
                    NSLog(@"点击了预定须知.....");
                    
                    _isReserve = YES;
                    break;
                case kScenicBtn_Tag:
                    NSLog(@"点击了景点介绍.....");
                    _isReserve = NO;
                    break;
                    
                default:
                    break;
            }
            
            [self.tableView reloadData];
            
        };
        return ticketVC;
    }
    return nil;
}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        
        return 40;
        
        
    }return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath   {
    if (indexPath.section == 0) {
        return 100;
    }else if(indexPath.section == 1){
        if (_isReserve) {
           return 600;
        }else{
            return 350;
        }
        
    }return 0;
    
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
