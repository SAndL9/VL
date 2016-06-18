//
//  AppDelegate.m
//  LLTravel
//
//  Created by lanouhn on 16/6/1.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "AppDelegate.h"
#import "LLLauchViewController.h"
#import "LLGuideViewController.h"
#import "LLUserDefaults.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //创建启动动画图
//    LLLauchViewController *lauch = [[LLLauchViewController alloc]initWithNibName:@"LLLauchViewController.xib" bundle:nil];
//    
//
//    self.window.rootViewController= lauch;
    
     //创建启动动画图
//    LLLauchViewController *lauchVc = [[LLLauchViewController alloc]init];
//    //把当前app的Windows的rootVc设置为启动图片
//    self.window.rootViewController = lauchVc;
    
    NSLog(@"%@",NSHomeDirectory());
    
    //创建引导页
    
    //判断当前启动的次数 用户是否是第一次启动,
    [LLUserDefaults initDefaults];//初始化
    if ([[LLUserDefaults getLaunchTimes] integerValue] == 1) {
        //是第一次启动 设置引导页
        LLGuideViewController *guideVc = [[LLGuideViewController alloc]init];
        //设置引导页
        guideVc.imageArray = @[@"guide_home",@"guide_steward_shop"];
        //将引导页设置成当前Windows的rootVC
        self.window.rootViewController = guideVc;
    }else{
        NSLog(@"当前是用户的第%ld次启动",[[LLUserDefaults getLaunchTimes] integerValue] + 1);
        //创建启动动画图
            LLLauchViewController *lauchVc = [[LLLauchViewController alloc]init];
            //把当前app的Windows的rootVc设置为启动图片
            self.window.rootViewController = lauchVc;
    }
    //更新启动的次数
    [LLUserDefaults setLaunchTimes:[NSString stringWithFormat:@"%ld",[[LLUserDefaults getLaunchTimes] integerValue] + 1]];
    //--------------
    
    [UMSocialData setAppKey:@"558a3b9767e58edac60036e4"];
    //设置微信和qq的appid
    [UMSocialWechatHandler setWXAppId:@"wxf5633c442cd64e42" appSecret:@"00e12a349e9d03af64d3be07ea1eec4c" url:@"www.baidu.com"];
    [UMSocialQQHandler setQQWithAppId:@"1104684907" appKey:@"AJ7WiB7cnRvpIbb4" url:@"www.guancheyi.com"];
    
    return YES;
}

/**
 *  分享到微信的代理回掉方法
 */

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.taobao.LLTravel" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LLTravel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"LLTravel.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
