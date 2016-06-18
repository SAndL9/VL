//
//  LLFillOrderViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/15.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLFillOrderViewController.h"
#import "LLSetoffDateCell.h"
#import "LLRoomDataModel.h"
#import "LLRoomTypePriceBtn.h"
#import "LLFillOrderCell.h"
#import "LLContactCell.h"
#import "OtherFillOrderCell.h"
#import "LLRoominfoView.h"

#define kContactTextField_Tag 1111
#define kMobileTextField_Tag  1112

@interface LLFillOrderViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//订单总额的按钮
@property (weak, nonatomic) IBOutlet UIButton *priceButton;

//存放不同类型的房间数据
@property(nonatomic,strong)NSMutableArray *roomArray;

@property(nonatomic,strong)UIView *secondSectionHeaderView; //section == 1时区头

@property(nonatomic,strong)NSMutableArray *currentDataArray;//存放当前要展示的房间时数据

@property(nonatomic,strong)NSString *stock;//存放剩余房间数


@property(nonatomic,strong)NSMutableDictionary *priceDic;//c存放不同房间 下单后的不同价格 其中key值对应房间类型 value对应该类型房间占用房间的总价格


@property(nonatomic,strong)LLRoominfoView *roomInfoView;//展示房间数据弹出的View





@end

@implementation LLFillOrderViewController

-(UIView *)secondSectionHeaderView{
    if (!_secondSectionHeaderView) {
        self.secondSectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size_width, 80)];
   
    //创建房间类型button
    CGFloat W =  size_width / self.roomArray.count;
    for (int i = 0; i < self.roomArray.count; i++) {
        NSDictionary *dic = self.roomArray[i];
        //取出房间类型
        NSString *roomTypeStr = [dic allKeys][0];
        //------取出该类型下最小价格 [dic allValues][0]表示某一类型房间对应的model数组 [dic allValues][0][0]表示取出这个数组下的第一个model对象。
        //------可以定义一个无限大的值 然后和里面的去比较 。。。？
        //通过for循环遍历 取出该房间类型所有房间数据中价格最低的房间数据model
        LLRoomDataModel *model = [dic allValues][0][0];
        
        for (int  i = 0; i < [dic allKeys].count; i++) {
            LLRoomDataModel *temModel = [dic allValues][0][i];
//            //判断如果second_price 为0的时候 取出显示的价格为second_price_basic  如果两个都为0 取出显示价格为first_price
//            NSString * price = model.second_price;
//            if ([price integerValue] == 0) {
//                price = model.second_price_basic ;
//            }
//            if ([price integerValue] == 0) {
//                price = model.first_price_basic ;
//            }
            
            NSInteger firstModelPrice = [[self judgeThePriceOfRoomWith:model]integerValue];
            NSInteger tempModelPrice = [[self judgeThePriceOfRoomWith:temModel]integerValue];
            
            
            
            if (firstModelPrice > tempModelPrice) {
                model = temModel;
            }
        }
        
        LLRoomTypePriceBtn *button = [[LLRoomTypePriceBtn alloc]initWithFrame:CGRectMake(i * W, 0, W, 80) roomType:roomTypeStr price:[self judgeThePriceOfRoomWith:model]];
        //设置tag值来区分不同类型的button
       [ button setTag:22222+i ];
        //判断当前button是不是最后一个
        if (i == self.roomArray.count - 1) {
            //隐藏lineView
            button.lineView.hidden = YES;
        }
        //给butto添加点击事件
        [button addTarget:self action:@selector(HnadRoomTypeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_secondSectionHeaderView addSubview:button];
        //判断给传递进来的房间类型 设置颜色
        if ([roomTypeStr isEqualToString:self.roomTypeStr]) {
            [button changeColorWith:[UIColor orangeColor]];
            //赋值
            //取出对应默认选择的房间类型来展示
            self.currentDataArray = [NSMutableArray arrayWithArray:[dic objectForKey:roomTypeStr]];
            [self.tableView reloadData];
        }
        
    }
    }
    return _secondSectionHeaderView;
}
#pragma mark--------显示房间价格----在懒加载里面用到
//--------
-(NSString *)judgeThePriceOfRoomWith:(LLRoomDataModel*)model{
    //判断如果second_price 为0的时候 取出显示的价格为second_price_basic  如果两个都为0 取出显示价格为first_price
    NSString * price = model.second_price;
    if ([price integerValue] == 0) {
        price = model.second_price_basic ;
    }
    if ([price integerValue] == 0) {
        price = model.first_price_basic ;
    }
    return price;
}

-(NSMutableArray *)roomArray{
    if (!_roomArray) {
        self.roomArray = [NSMutableArray array];
    }
    return _roomArray;
}
-(NSMutableArray *)currentDataArray{
    if (!_currentDataArray) {
        self.currentDataArray = [NSMutableArray array];
    }
    return _currentDataArray;
}

-(LLRoominfoView *)roomInfoView{
    if (!_roomInfoView) {
        self.roomInfoView = [[LLRoominfoView alloc]initWithFrame:CGRectMake(0, 0, size_width, size_height)];
        //添加到主屏幕上 不让其导航栏盖住。。。。。。。
        [[UIApplication sharedApplication].keyWindow addSubview:_roomInfoView];
    }
    return _roomInfoView;
}


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = NO;
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadData];
    [self loadSubViews];
    //注册出发日期cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LLSetoffDateCell" bundle:nil] forCellReuseIdentifier:@"LLSetoffDateCell"];
    
    //注册房间cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LLFillOrderCell" bundle:nil] forCellReuseIdentifier:@"LLFillOrderCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OtherFillOrderCell" bundle:nil] forCellReuseIdentifier:@"OtherFillOrderCell"];
    
    //注册常用联系人cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LLContactCell" bundle:nil] forCellReuseIdentifier:@"LLContactCell"];
    
    
}
#pragma mark ----
-(void)loadSubViews{
    //创建表头
    UIView *HeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size_width, 40)];
    self.tableView.tableHeaderView = HeadView;
    UILabel *headerLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, size_width - 10 * 2, 30)];
    headerLab.font = [UIFont systemFontOfSize:13];
    headerLab.text = [self.dataDic objectForKey:@"product_name"];
    [HeadView  addSubview:headerLab];
}
#pragma mark -------
-(void)loadData{
    //将不同类型的房间数据 转成model后 存放在全局数组中
    NSDictionary *roomTypeDic = [NSDictionary dictionaryWithDictionary:[self.dataDic objectForKey:@"room"]];
    //初始化房间价格字典
    self.priceDic  = [NSMutableDictionary dictionary ];
    
    //遍历不同房间下的数据
    for (NSString *typeStr in [roomTypeDic allKeys] ) {
        //把不同的房间类型
        
        //初始化不同房间类型对应的订单总价格
        [self.priceDic setObject:@"0" forKey:typeStr];
        
        
        
        //创建一个临时存放数据的字典,存放不同类型房间对应的房间数据 房间为字典的key 党建model数组为value
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        //创建一个临时存放某一个类型房间数组的model的数组
        NSMutableArray *temArray = [NSMutableArray array];
        //根据遍历得到的房间类型.遍历这个类型下的房间数据 将数据转成model 存到相应的临时数据里
        for (NSDictionary *dic in [roomTypeDic objectForKey:typeStr]) {
            //创建model
            LLRoomDataModel *model = [[LLRoomDataModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            //----------因为请求的数据没有这两个字段  所以添加到字段
            //添加默认儿童和成人字段为0
            model.adultNumStr = @"0";
            model.childNumStr = @"0";
            [temArray addObject:model];
        }
        //将某一房间类型下的model数据和key值存到临时字典中
        [tempDic setObject:temArray forKey:typeStr];
        //将某一类对应的key-model数据 存放全局数组中
        [self.roomArray addObject:tempDic];
    }
    //
    NSLog(@"^^^##%#%^##%@",self.roomArray);

}
#pragma mark-------订单总额按钮发生变化
//订单总额按钮发生变化
- (IBAction)priceButtonClicked:(UIButton *)sender {
    NSLog(@"点击了订单总额.........");
}
#pragma mark-------订单按钮的点击
//订单按钮的点击
- (IBAction)submitOrderBtnClicked:(UIButton *)sender {
    NSLog(@"点击了订单按钮、、。。。。。。。。。。");
}


#pragma mark -------UITableViewDateSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return self.currentDataArray.count;
            break;
        case 2:
            return 0;
            break;
        case 3:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}

//返回cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   //判断出发riqicell
    if (indexPath.section == 0 && indexPath.row == 0) {
        LLSetoffDateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLSetoffDateCell" forIndexPath:indexPath];
        //给出发日期赋值
        NSString *setoffDataStr = [self.dataDic objectForKey:@"setoff_date"];
        NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:[setoffDataStr doubleValue]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        cell.dateLab.text = [formatter  stringFromDate:date];
        
    }else if (indexPath.section == 1){
        //返回相应的房间cell
//      __weak  LLFillOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLFillOrderCell" forIndexPath:indexPath];
        
        //获得相应row需要显示的房间数据
        LLRoomDataModel *model = self.currentDataArray[indexPath.row];
        
        if (model.num.integerValue >2) {
            //返回相应的房间cell
            LLFillOrderCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"LLFillOrderCell" forIndexPath:indexPath];
            self.stock = model.stock;
            //实现成人加号
            cell.adultAdd = ^(NSString*price){
                NSLog(@"*****@*@*@*@*%@",price);
                [self setPrice:price model:model];
                
            };
            //成人减号
            cell.adultReduce = ^(NSString *price) {
                NSLog(@"========%@",price);
                [self setPrice:price model:model];
            };
            //儿童加号
            cell.childAdd=^(NSString*price){
            NSLog(@"=___________=%@",price);
                [self setPrice:price model:model];
            };
            //儿童减号
            cell.childReduce=^(NSString*price){
            NSLog(@"=^^^^^^=%@",price);
                [self setPrice:price model:model];
            };
            
            //给cell赋值
            [cell setCellDataWith:model];
            return cell;
            
        }else {
            //入住的总数
            OtherFillOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OtherFillOrderCell" forIndexPath:indexPath];
            [cell setCellDataWith:model];
            return cell;
        }
//        
//        self.stock = model.stock;
//        //实现成人加号
//        cell.adultAdd =^{
//            //取出成人数
//            NSInteger  adultNum = [model.adultNumStr integerValue];
//            //1.成人加号
//            adultNum++;
//            model.adultNumStr = [NSString stringWithFormat:@"%ld",adultNum];
//            cell.adultNumLab.text = model.adultNumStr;
//            
//            //2.修改当前房间剩余数
//            cell.stockLab.text = [NSString stringWithFormat:@"%@间",[self judgeTheStockRoomNumWith:model withStock:self.stock]];
//            //更新model值中剩余房间数据
//            model.stock =  [cell.stockLab.text substringToIndex:cell.stockLab.text.length - 1];
//            
//
//        };
//        //成人减号
//        cell.adultReduce = ^{
//            
//        };
//        
//        
//        //给cell赋值
//     
//        [cell setCellDataWith:model];
//        
//        return cell;
    }else if(indexPath.section == 3){
        //重用联系人.........
        LLContactCell   *cell = [tableView dequeueReusableCellWithIdentifier:@"LLContactCell" forIndexPath:indexPath];
        cell.contactTextField.delegate = self;
        cell.mobileTextField.delegate = self;
        cell.contactTextField.tag = kContactTextField_Tag;
        cell.mobileTextField.tag = kMobileTextField_Tag;
        cell.buttonClick = ^{
            NSLog(@"点击了常用联系人.....");
        };
        return cell;
    }
    
    
    
  
    return [[UITableViewCell alloc]init];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }else if(indexPath.section == 1){
        return 100;
    }else if(indexPath.section == 3){
        return 125;
    }
    return 0;
}

//返回分区视图
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return self.secondSectionHeaderView;
    }
    return [[UIView alloc]init];
}
//返回的分区高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 80;
    }else if(section == 2){
        return 10;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LLRoomDataModel *model = self.currentDataArray[indexPath.row];
    
    [self.roomInfoView updateDataWith:model];
    
}


#pragma mark-------点击不同类型的房间button点击方法
-(void)HnadRoomTypeBtnAction:(UIButton *)sender{
    //改变按钮颜色
    for (LLRoomTypePriceBtn *btn in self.secondSectionHeaderView.subviews) {
        if (btn.tag == sender.tag) {
            //选中的颜色
            [btn changeColorWith:[UIColor orangeColor]];
            
        }
        else{
            [btn changeColorWith:[UIColor darkGrayColor]];
        }
    }
    NSInteger index = sender.tag - 22222;
    //取出相应点击button对应的房间类型数据
    NSDictionary *currentDic = self.roomArray[index];
    //点击的房间类型为...
    NSLog(@"()()()()()()%@",[currentDic allKeys][0]);
    
    //根据点击的房间类型 切换当前显示的房间数据
    NSString *tempName = [currentDic allKeys][0];
    self.currentDataArray = [NSMutableArray arrayWithArray:[currentDic objectForKey:tempName]];
    [self.tableView reloadData];
    
}

#pragma Mark-----计算当前房间剩余数
-(NSString*)judgeTheStockRoomNumWith:(LLRoomDataModel*)model withStock:(NSString *)stock{
    //计算当前一共多少人
    NSInteger total = [model.adultNumStr integerValue] + [model.childNumStr integerValue];
    //计算总人数占用的房间
    NSInteger usedRoomNum = total / [model.num integerValue] + (total % [model.num integerValue ]> 0 ?1:0);
    //剩余房间数
    NSInteger newstock = [stock integerValue] - usedRoomNum;
    return [NSString stringWithFormat:@"%ld",newstock];

    
}

#pragma mark -----UITextFieldDelegate
//点击return 回收键盘  让tab上移250
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
     self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.contentInset.top + 250, 0, self.tableView.contentInset.bottom, 0);
    return [textField resignFirstResponder];
}
//开始编辑的时候
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == kContactTextField_Tag) {
        NSLog(@"输入的联系人%@",textField.text);
    }
    if (textField.tag == kMobileTextField_Tag) {
        NSLog(@"输入的是手机号%@",textField.text);
    }
    //让tab上衣防止键盘被遮盖住
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.contentInset.top - 250, 0, self.tableView.contentInset.bottom, 0);
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
     self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.contentInset.top + 250, 0, self.tableView.contentInset.bottom, 0);
    [self.view endEditing:YES];
}

//设置房间价格
-(void)setPrice:(NSString*)price model:(LLRoomDataModel*)model{
    //取出房间类型
    NSString *typeName = model.cabin_name;
    //根据房间类型 更新对应的类型下的订单价格
    [self.priceDic  setObject:price forKey:typeName];
    
    //取出所有房间类型下的订单金额
    CGFloat allPrice = 0;
    for (NSString *priceStr in [self.priceDic allValues]) {
        allPrice = allPrice + [priceStr floatValue];
    }
    
    //给button赋值
    [self.priceButton setTitle:[NSString stringWithFormat:@"%.2f",allPrice] forState:UIControlStateNormal];
    
    
    
//    [self.priceButton setTitle:price forState:UIControlStateNormal];
    
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
