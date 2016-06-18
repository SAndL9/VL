//
//  LLAboutMeViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/18.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLAboutMeViewController.h"
#import "LLAboutMeIconCell.h"
#import "LLUserDefaults.h"
#import "LLLoginDataModel.h"
#import "UIImageView+WebCaChe.h"
#import "LLAboutMeOtherCell.h"

@interface LLAboutMeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property(nonatomic,strong)NSMutableArray *nameDataSource;//存放前面的lab数据

@property(nonatomic,strong)NSMutableArray *DetailDataSource;//存放右面的详细信息

@end

@implementation LLAboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人详情";
   
    self.nameDataSource = [NSMutableArray arrayWithObjects:@"姓名",@"手机号",@"邮箱",@"性别",@"出生日期",@"证件",@"地址", nil];
    LLLoginDataModel *model = [LLUserDefaults getUserInfo];
    self.DetailDataSource = [NSMutableArray arrayWithObjects:model.realname,model.phone,model.email,model.sex,model.birthday,model.idnumber,model.address, nil];

    //注册头像cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LLAboutMeIconCell" bundle:nil] forCellReuseIdentifier:@"LLAboutMeIconCell"];
    //注册下面的cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LLAboutMeOtherCell" bundle:nil] forCellReuseIdentifier:@"LLAboutMeOtherCell"];
}

#pragma mark -----------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView   {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        LLAboutMeIconCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLAboutMeIconCell"];
         NSString *avaterStr = [NSString stringWithFormat:@"%@%@",URL_Base,[LLUserDefaults getUserInfo].avater];
         [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:avaterStr] placeholderImage:[UIImage imageNamed:@"bb"]];
        return cell;
    }
 
    LLAboutMeOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLAboutMeOtherCell" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            cell.NameLab.text = _nameDataSource[indexPath.row - 1];
            cell.detailLab.text = _DetailDataSource[indexPath.row -1];
        }else{
            cell.NameLab.text = _nameDataSource[indexPath.row - 1 + 4];
            cell.detailLab.text = _DetailDataSource[indexPath.row - 1 + 4];
        }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 63;
    }else{
        return 44;
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
