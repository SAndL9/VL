//
//  LLShipViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/7.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLShipViewController.h"
#import "LLNetWorkManage.h"
#import "LLCycleScrollViewDataModel.h"
#import "LLLineDataModel.h"
#import "LLSelectionTravelDataModel.h"
#import "SDCycleScrollView.h"
#import "LLCustomView.h"
#import "LLCalendarSectionHeaderView.h"
#import "LLShipLineCell.h"
#import "LLShipDetailViewController.h"
#import "LLCalendarViewController.h"
#import "LLCalendarModel.h"


#import "LLDetailLineViewController.h"

@interface LLShipViewController () <UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//蒙版View
@property (weak, nonatomic) IBOutlet UIView *corverView;

//轮播数据源
@property(nonatomic,strong)NSMutableArray *cycleViewDataArray;

@property(nonatomic,strong)NSMutableArray *lineDataArray;//航线数据源
//精选旅游数据
@property(nonatomic,strong)NSMutableArray *selectionTraveDataArray;


@property(nonatomic,strong)NSMutableArray *calendarArray;//存放日历数据
@end
//航线标识
static NSString *ShipLineCellID = @"LLShipLineCell";

@implementation LLShipViewController

-(NSMutableArray *)cycleViewDataArray{
    if (!_cycleViewDataArray) {
        self.cycleViewDataArray = [NSMutableArray array];
    }
    return _cycleViewDataArray;
}
-(NSMutableArray *)lineDataArray{
    if (!_lineDataArray) {
        self.lineDataArray = [NSMutableArray array];
    }
    return _lineDataArray;
}
-(NSMutableArray *)selectionTraveDataArray{
    if (!_selectionTraveDataArray) {
        self.selectionTraveDataArray = [NSMutableArray array];
    }
    return _selectionTraveDataArray;
}

-(NSMutableArray *)calendarArray{
    if (!_calendarArray) {
        self.calendarArray = [NSMutableArray array];
    }
    return _calendarArray;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    //显示navigationBar
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"邮轮";
#warning -------先加载数据 然后在进行布局
    
    [self loadData];
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"calendarCell"];
    //注册精品航线的cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LLShipLineCell" bundle:nil] forCellReuseIdentifier:ShipLineCellID];
    
}
#pragma mark -----布局视图
-(void)loadSubViews{
    //创建表头
    UIView *headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size_width, 270)];
    self.tableView.tableHeaderView = headerview;
    headerview.backgroundColor = [UIColor redColor];
    
    
    //取出加载轮播图的图片路径
    NSMutableArray *picUrl = [NSMutableArray array];
    for (LLCycleScrollViewDataModel  *model in self.cycleViewDataArray) {
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",URL_Base,model.src];
        [picUrl addObject:urlStr];
    }
    //创建轮播图
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, size_width, 150) imageURLStringsGroup:picUrl];
    //一张的时候 是否隐藏
//    cycleScrollView.hidesForSinglePage = NO;
    cycleScrollView.infiniteLoop = YES;
    //代理对象
    cycleScrollView.delegate = self;
    [headerview addSubview:cycleScrollView];
    
    //-----------创建航线
    LLCustomView *lineView = [[LLCustomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(cycleScrollView.frame), size_width, 120) WithDataArray:self.lineDataArray];
    lineView.ShipLineButtonClick = ^(NSInteger index){
        LLLineDataModel *model = self.lineDataArray[index-2000];
    
        switch (index-2000) {
            case 0:{
                LLDetailLineViewController *DeatilLineVC =[[LLDetailLineViewController   alloc]init];
                DeatilLineVC.DetailAssistant_id = @"0";
                DeatilLineVC.DetailLine =model.line_id;
                DeatilLineVC.DetailCity_id = @"149";
                [self.navigationController pushViewController:DeatilLineVC animated:YES];
                NSLog(@"点击的是%@",model.line_name);
            
            } break;
            case 1:{
                NSLog(@"点击的是%@------%@",model.line_name,model.line_id);
                
                LLDetailLineViewController *DeatilLineVC =[[LLDetailLineViewController   alloc]init];
                DeatilLineVC.DetailAssistant_id = @"0";
                DeatilLineVC.DetailLine =model.line_id;
                DeatilLineVC.DetailCity_id = @"149";
                [self.navigationController pushViewController:DeatilLineVC animated:YES];
            } break;
            case 2:{
                NSLog(@"点击的是%@",model.line_name);
                LLDetailLineViewController *DeatilLineVC =[[LLDetailLineViewController   alloc]init];
                DeatilLineVC.DetailAssistant_id = @"0";
                DeatilLineVC.DetailLine =model.line_id;
                DeatilLineVC.DetailCity_id = @"149";
                [self.navigationController pushViewController:DeatilLineVC animated:YES];
            } break;
            case 3:{
                NSLog(@"点击的是%@",model.line_name);
                LLDetailLineViewController *DeatilLineVC =[[LLDetailLineViewController   alloc]init];
                DeatilLineVC.DetailAssistant_id = @"0";
                DeatilLineVC.DetailLine =model.line_id;
                DeatilLineVC.DetailCity_id = @"149";
                [self.navigationController pushViewController:DeatilLineVC animated:YES];
            }
                break;
          
                
            default:
                break;
        }
    };
    [headerview addSubview:lineView];
    

}
#pragma mark ----加载数据
-(void)loadData{
    NSLog(@"开始加载数据.......");
    //显示加载圈
        [self showHUDWith:@"加载中...."];
    //请求邮轮主界面的数据
    NSDictionary *paramDic = @{@"city_id":@"149",@"assistant_id":@"0"};
    [LLNetWorkManage requestPOSTWithUrlStr:URL_ShipFirst paramDict:paramDic finish:^(id responseObject) {//数据请求成功
        NSLog(@"请求邮轮数据成功......%@",responseObject);
        //隐藏加载圈
        [self hidenHUD];
        //隐藏蒙版View
        self.corverView.hidden = YES;
        
        //获得字典数据源
        NSDictionary *returnDataDic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSDictionary *dataDic = [returnDataDic objectForKey:@"data"];
        //------------------------获得轮播图数据
        NSArray *adArray = [dataDic objectForKey:@"ad"];
        //复用首页的轮播图的model
        for (NSDictionary *dic in adArray) {
            LLCycleScrollViewDataModel *model = [[LLCycleScrollViewDataModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            //？？？？？？？
            //单独给goto_赋值
            model.goto_ = [dic objectForKey:@"goto"];
            [self.cycleViewDataArray addObject:model];
        }
        
        //-----------航线数据-----------
        //
        NSArray *lineDataArr = [dataDic objectForKey:@"line_list"];
        for (NSDictionary *dic in lineDataArr) {
            LLLineDataModel *model = [[LLLineDataModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.lineDataArray addObject:model];
        }
        //--------------特价精品航线数据---------------
        NSArray *selectionLineDataArr = [dataDic objectForKey:@"tehuichanpin"];
        //遍历数组 将数据转成model
        for (NSDictionary *dic in selectionLineDataArr) {
            LLSelectionTravelDataModel *model = [[LLSelectionTravelDataModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.selectionTraveDataArray addObject:model];
            NSLog(@"***********%@",self.selectionTraveDataArray);
        }
        //----------日历--------------
        NSArray *calendarArr = [dataDic objectForKey:@"rili"];
        for (NSDictionary  *tempDic in calendarArr) {
            LLCalendarModel *model = [[LLCalendarModel alloc]init];
            [model setValuesForKeysWithDictionary:tempDic];
            [self.calendarArray addObject:model];
        }
        
        
        
        
         [self.tableView reloadData];
        
         [self loadSubViews];
        
    } enError:^(NSError *error) {
        //隐藏加载圈
                [self hidenHUD];
        self.corverView.hidden = YES;
        
    }];
     
}
#pragma mark -----点击轮播图跳转
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    //获得点击的第几张轮播图,取出对应的model数据
    LLCycleScrollViewDataModel *model = self.cycleViewDataArray[index];
    NSString *goto_ = model.goto_;
    //字符串 -----》字典
    //取出model.goto_中对应的json数据下的prodeuctID
    NSData *gotoData = [goto_ dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *gotoDic = [NSJSONSerialization JSONObjectWithData:gotoData options:NSJSONReadingMutableContainers error:nil];
    NSString *productID = [gotoDic objectForKey:@"product_id"];
    NSLog(@"..............%@",productID);
    
    //点击轮播图push到相应的邮轮详情界面
    LLShipDetailViewController *shipDetailVc = [[LLShipDetailViewController alloc]init];
    //属性传值
    shipDetailVc.product_id = productID;
    [self.navigationController pushViewController:shipDetailVc animated:YES];
}


#pragma mark ----------UITableViewData-----------
//返回分区个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
//返回分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //如果是第一个分区 返回1 个 如果是2分区 返回数据源的个数
    return (section == 0) ? 1 : self.selectionTraveDataArray.count;
    
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"calendarCell"];
        cell.imageView.image = [UIImage imageNamed:@"邮轮日历"];
        cell.textLabel.text = @"邮轮日历";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        return cell;
    }
#warning --------上面注册了下面一定要用 forIndexPath 这个方法 
    //返回精品航线
    LLShipLineCell *cell = [tableView dequeueReusableCellWithIdentifier:ShipLineCellID forIndexPath:indexPath];
    //取出该行要展示的model 数据
    LLSelectionTravelDataModel *model  = self.selectionTraveDataArray[indexPath.row];
    //展示数据
    [cell setCellDataModel:model];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }
    //计算cell上产品名的高度
    //取出该行要展示的model 数据
    LLSelectionTravelDataModel *model  = self.selectionTraveDataArray[indexPath.row];
   CGFloat contentHeight = [self GetHeightWith:model.product_name WithFont:14];
    return 200 + contentHeight;
}

//返回区头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        LLCalendarSectionHeaderView *headView = [[LLCalendarSectionHeaderView alloc]initWithFrame:CGRectMake(0, 0, size_width, 44)];
        return headView;
    }
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, size_width, 30)];
}
//返回区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 44;
    }
    return 30;
}
//返回区尾的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 20;
    }
    return 0.5;

}
#pragma mark ----根据cell上的字符串高度和label的字体大小 来计算label的高度
-(CGFloat)GetHeightWith:(NSString*)contentStr WithFont:(CGFloat)font{
   //参数 参数1  
    CGSize size = [contentStr boundingRectWithSize:CGSizeMake(size_width - 20 * 2, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    //如果content有内容 就减去一行的高度
    if (contentStr.length > 0) {
        return size.height - 17;
    }
    return size.height;
}

//点击选中的cell调皮转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSLog(@"点击的是日历.......");
        LLCalendarViewController *calendarVc = [[LLCalendarViewController alloc]init];
        calendarVc.calendarArr = [NSArray arrayWithArray:self.calendarArray];
        [self.navigationController pushViewController:calendarVc animated:YES];
    }else{
    //点击轮播图push到相应的邮轮详情界面
    LLShipDetailViewController *shipDetailVc = [[LLShipDetailViewController alloc]init];
    LLSelectionTravelDataModel *model =_selectionTraveDataArray[indexPath.row];
    //属性传值
    shipDetailVc.product_id = model.product_id;
        [self.navigationController pushViewController:shipDetailVc animated:YES];
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
