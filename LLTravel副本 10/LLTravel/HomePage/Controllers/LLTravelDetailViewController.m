//
//  LLTravelDetailViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/11.
//  Copyright © 2016年 taobao. All rights reserved.
//

#define kRouteButton_Tag 10001
#define kProductFeaturesButton_Tag 10002


#import "LLTravelDetailViewController.h"
#import "SDCycleScrollView.h"
#import "LLNetWorkManage.h"
#import "LLDetailTravelSectionHeaderView.h"
#import "LLBottomPresentView.h"
#import "LLTravelPresentModel.h"
#import "UIImageView+WebCache.h"
#import "LLFirstRouteDateCell.h"

@interface LLTravelDetailViewController ()<UITableViewDataSource,UITableViewDelegate,LLDetailTravelSectionHeaderViewDelegate>

@property(nonatomic,strong)UITableView *tableView;


//轮播数据源
@property(nonatomic,strong)NSMutableArray *cycleDataArray;


//用于存储价格名字和编号的字典
@property(nonatomic,strong)NSDictionary *NamePriceDic;

@property(nonatomic,strong)LLDetailTravelSectionHeaderView *sectionHeaderView;

//用于储存下面的视图
@property(nonatomic,strong)NSMutableArray *PresentDataArray;

//定义一个Bool值 用于记录是否选中的是行程介绍 还是产品特色 YES 默认选中的是第一个
@property(nonatomic,assign)BOOL isRouteButton;

//用于接收标签文字特色
@property(nonatomic,copy)NSString *PresentTempStr;



@end
static NSString *detailTravelCellID = @"detailTravelCellID";
@implementation LLTravelDetailViewController

-(NSMutableArray *)cycleDataArray{
    if (!_cycleDataArray) {
        self.cycleDataArray = [NSMutableArray array];
    }
    return _cycleDataArray;
    
}
-(NSDictionary *)NamePriceDic{
    if (!_NamePriceDic) {
        self.NamePriceDic = [NSDictionary dictionary];
    }
    return _NamePriceDic;
}
-(LLDetailTravelSectionHeaderView *)sectionHeaderView{
    if (!_sectionHeaderView) {
        self.sectionHeaderView = [[LLDetailTravelSectionHeaderView alloc]initWithFrame:CGRectMake(0, 0, size_width, 37)];
        _sectionHeaderView.delegate = self;
    }
    return _sectionHeaderView;
}
-(NSMutableArray *)PresentDataArray{
    if (!_PresentDataArray) {
        self.PresentDataArray = [NSMutableArray array];
    }
    return _PresentDataArray;
}

    //-------行程介绍和产品特色的button点击按钮
-(void)buttonClick:(NSInteger)tag{
    switch (tag) {
        case kRouteButton_Tag:
            NSLog(@"点击的是行程介绍..........");
            _isRouteButton =YES;
            
            break;
            case kProductFeaturesButton_Tag:
            NSLog(@"点击的是产品特色.......");
            _isRouteButton = NO;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBar.alpha = 0.0;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, size_width, size_height) style:UITableViewStyleGrouped];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:detailTravelCellID];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LLFirstRouteDateCell" bundle:nil] forCellReuseIdentifier:@"LLFirstRouteDateCell"];
    //设置默认值
    _isRouteButton = YES;
    
    NSLog(@"llllllll------%@",_pid);
    [self loadData];
 
}


#pragma mark ------ 
-(void)loadSubViews{
    self.title = @"产品详情";
    
    UIView *HeadView = [[UIView  alloc]initWithFrame:CGRectMake(0, 0, size_width, 280)];
    self.tableView.tableHeaderView = HeadView;
//    HeadView.backgroundColor  = [UIColor orangeColor];
    
    //------进来时候 让nav隐藏 当tableView的contentoffset.y大于64的时候 让其显现  当小于64的时候 隐藏.....。。。
    
//    if (self.tableView.contentOffset.y < 64) {
//        self.navigationController.navigationBar.alpha += 0.1;
//    }else if(self.tableView.contentOffset.y > 64){
//        self.navigationController.navigationBar.alpha -= 0.1;
//    }
    
    //-------添加轮播图
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, size_width, 150) imageURLStringsGroup:self.cycleDataArray];
    [HeadView addSubview:cycleScrollView];
    
    //-----------添加下面的名字
    //-------把其下面的封装到一个view上面  然后 进行布局
    //名字lab
    UILabel  *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(cycleScrollView.frame) + 10, size_width, 35)];
//    nameLab.backgroundColor = [UIColor redColor];
    nameLab.text = [NSString stringWithFormat:@"<%@>",[self.NamePriceDic objectForKey:@"product_name"]];
    nameLab.font = [UIFont systemFontOfSize:15];
    [HeadView addSubview:nameLab];
    //------------价格-----
    UILabel *priceLab = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(nameLab.frame) + 5, size_width, 35)];
    priceLab.textColor = [UIColor orangeColor];
    priceLab.font = [UIFont systemFontOfSize:14];
    priceLab.text = [NSString stringWithFormat:@"微旅价:￥%@起",[self.NamePriceDic objectForKey:@"adult_price"]];
    [HeadView addSubview:priceLab];
    
    UIView *lineVC = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(priceLab.frame) + 2, size_width, 2)];
    lineVC.backgroundColor  = [UIColor grayColor];
    [HeadView addSubview:lineVC];
    //------------编号-----------
    UILabel  *product_snLab = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lineVC.frame)+5, size_width, 30)];
    product_snLab.text = [NSString stringWithFormat:@"编号:%@",[self.NamePriceDic objectForKey:@"product_sn"]];
    product_snLab.font = [UIFont systemFontOfSize:12];
    [HeadView addSubview:product_snLab];
    //----------经营许可证
    UILabel *businesslicNoLab = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(product_snLab.frame) + 5, size_width, 30)];
    businesslicNoLab.text = [NSString stringWithFormat:@"经营许可证:%@",[self.NamePriceDic objectForKey:@"businesslicNo"]];
    businesslicNoLab.font = [UIFont systemFontOfSize:12];
    
    [HeadView addSubview:businesslicNoLab];
    NSLog(@"%f",CGRectGetMaxY(businesslicNoLab.frame));
    
    
    //-----------放到足尾------------
    UIView *footerVC = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size_width, 200)];
    footerVC.backgroundColor = [UIColor orangeColor];
   
    
    
    //-------------PresentLab------
    UILabel *PresentLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size_width, 40)];
    PresentLab.text = @"相关产品推荐";
    [footerVC  addSubview:PresentLab];
    
    
    
    //-------------
    for (int i = 0; i < 2; i++) {
        LLTravelPresentModel *model = self.PresentDataArray[i];
        CGFloat W = (size_width - 10 * 3)/2;
        LLBottomPresentView *BottomPeresentVC = [[LLBottomPresentView alloc]initWithFrame:CGRectMake((W +10)*i + 10, CGRectGetMaxY(PresentLab.frame), W, 150)];
        BottomPeresentVC.backgroundColor = [UIColor redColor];
        [BottomPeresentVC.IconImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"默认图2@2x 2"]];
        BottomPeresentVC.nameLab.text = model.product_name;
        BottomPeresentVC.priceLab.text = [NSString stringWithFormat:@"￥%@起",model.adult_price];
        BottomPeresentVC.tag = 101010+i;
        BottomPeresentVC.userInteractionEnabled = YES;
        //---------添加手势---
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapGestureReG:)];
        [BottomPeresentVC addGestureRecognizer:tap];
        [footerVC addSubview:BottomPeresentVC];
    }
     self.tableView.tableFooterView = footerVC;
}
#pragma mark ---------添加的寿司
-(void)TapGestureReG:(UITapGestureRecognizer *)tap{
   
   
    NSInteger tag1 = tap.view.tag;
    NSLog(@"111111------%ld-----",tag1);
    
    LLTravelDetailViewController *detailVC = [[LLTravelDetailViewController alloc]init];
    LLTravelPresentModel *model = self.PresentDataArray[tag1 - 101010];
    detailVC.pid = model.product_id;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark--------
-(void)loadData{
    NSDictionary *paramDIC = @{@"pid":_pid,@"check":@"see"};
    [LLNetWorkManage requestPOSTWithUrlStr:URL_TravelDetail paramDict:paramDIC finish:^(id responseObject) {
        //获得数据
        //最外层的字典
        NSDictionary *returnDic = responseObject[@"data"];
        
        NSArray *array = [returnDic objectForKey:@"albums"];
        //--------------轮播图---
        for (NSDictionary *tempDic in array) {
            NSMutableString *str = [tempDic objectForKey:@"picture"];
            if ([str hasPrefix:@"http:"]) {
                 [self.cycleDataArray addObject:str];
            }else{
             NSString *str1 = [NSString  stringWithFormat:@"%@%@",URL_Base,str];
                [self.cycleDataArray addObject:str1];
            }
           
        }
        NSLog(@".......%@",self.cycleDataArray);
        
        //----------------用户名字 和价格编号 -----
        _NamePriceDic  = [returnDic objectForKey:@"product_info"];
        NSLog(@"..!!!!!!>......%@",_NamePriceDic);
        //----------行程介绍----------
        
        //--------------------
        NSArray *tempArray = [returnDic objectForKey:@"tj_products"];
        for (NSDictionary*dic in tempArray) {
            LLTravelPresentModel *model = [[LLTravelPresentModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.PresentDataArray addObject:model];
            NSLog(@"*****@*!*@*@#*@#*%@",_PresentDataArray);
        }
        //------特色产品的标签文字------------
        _PresentTempStr = [[returnDic objectForKey:@"product_info"] objectForKey:@"feature"];
      
        NSLog(@"-----+++@+@+@++@+%@",_PresentTempStr);
        
        
        
        
        
        
        
        [self loadSubViews];
        
        
        [self.tableView reloadData];
    } enError:^(NSError *error) {
        
        
    }];
    
}
#pragma mark ----------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else{
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:detailTravelCellID];
        cell.textLabel.text = @"最近团期";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else if (indexPath.section == 1){
        if (_isRouteButton) {
            //产品特色
            
//            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:detailTravelCellID];
            LLFirstRouteDateCell*cell = [tableView dequeueReusableCellWithIdentifier:@"LLFirstRouteDateCell" forIndexPath:indexPath];
            

            return cell;
        }else{
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:detailTravelCellID];
            
            //把标签字符串 转换成字符串
            NSAttributedString *attribuSr = [[NSAttributedString alloc]initWithData:[self.PresentTempStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
            cell.textLabel.attributedText = attribuSr;
            //处理</br>的换行
            //去掉cell的lab上的换行
            NSString *tempStr = cell.textLabel.text;
            //
            tempStr = [tempStr stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            cell.textLabel.text = tempStr;

            
            
            
//            cell.textLabel.text = _PresentTempStr;
            cell.textLabel.numberOfLines = 0;
            
            
        
            
            
            return cell;
        }
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:detailTravelCellID];
        cell.textLabel.text = @"费用&预定须知";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    
     return [[UITableViewCell alloc]init];
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *hearVC = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size_width, 45)];
        [hearVC addSubview:self.sectionHeaderView];
        return hearVC;
    }
    return nil;
}
//返回分区的高

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 20;
    }else if (section == 1){
        return 40;
    }
    return 5;
}


//返回区尾的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 0.5;
    
}


//返回高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (_isRouteButton) {
            return 350;
        }else{
           
                return [self CellHeightWithStr:_PresentTempStr withFontSize:15];

            
            
        }
    }
    return 44;
}

#pragma mark --------计算文字的高度来进行cell高度展示
-(CGFloat)CellHeightWithStr:(NSString*)contentStr withFontSize:(CGFloat)font{
//    //参数 参数1
//    if (contentStr.length ==  0) {
//        return 44;
//    }
    CGSize size = [contentStr boundingRectWithSize:CGSizeMake(size_width - 10 * 2, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return size.height;
}


#pragma mark--------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.navigationController.navigationBar.alpha = scrollView.contentOffset.y / 108;
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
