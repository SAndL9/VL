//
//  LLDefine.h
//  LLTravel
//
//  Created by lanouhn on 16/6/1.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

//宏定义屏幕宽度
#define size_width [UIScreen mainScreen].bounds.size.width
//宏定义屏幕的高度
#define size_height [UIScreen mainScreen].bounds.size.height

//-------------------------HTTPDefine-------------
//请求域名  -------以防 出现不含域名.......
#define URL_Base @"https://www.weilv100.com"

//首页
#define URL_CycleScrollView @"https://www.weilv100.com/api/ad/ad_img_show/75/149" //首页轮播图接口

//公告
#define URL_News @"https://www.weilv100.com/api/appHome/getWeilvAnnounce" //公告栏


#define URL_PeriPhera @"https://www.weilv100.com/api/appHome/getHomeInfo" //周边景点

#define URL_StewardList @"https://www.weilv100.com/api/assistant/lists"//请求管家列表

#define URL_ShipStack @"https://www.weilv100.com/api/appHome/getHomeInfo"//游学 邮轮 门票


//------------------2级页面的----------------
#define URL_ShipFirst @"http://www.weilv100.com/api/cruise/index" //邮轮的主界面

#define URL_Banner @"https://www.weilv100.com/api/ad/ad_img_show/119/149"//更多景点

#define URL_MoreTravel @"https://www.weilv100.com/api/appHome/getChoiceDestAdList"//更多旅行目的按钮

#define URL_ShipDetail @"https://www.weilv100.com/api/cruise/product"//邮轮详情

#define URL_DetailLine  @"https://www.weilv100.com/api/cruise/product_list"//航线的详情

#define URL_DetailTravel @"https://www.weilv100.com/api/newtravel/getlist" //目的地详情页面

//3.	获取旅游详情页面数据接口
#define URL_TravelDetail @"https://www.weilv100.com/api/newtravel/detail"

//管家详情
#define URL_StewardDetail @"https://www.weilv100.com/api/assistant/info"


#define URL_CityList @"http://www.weilv100.com/api/route/region"//城市列表

//
#define URL_Travel @"https://www.weilv100.com/api/newtravel/index" //旅游详情


//点击“踏青登山”的接口是：
#define URL_GoHiking @"https://www.weilv100.com/api/newtravel/getlist"




#define URL_Login @"http://www.weilv100.com/api/member/login_action" //登录接口



