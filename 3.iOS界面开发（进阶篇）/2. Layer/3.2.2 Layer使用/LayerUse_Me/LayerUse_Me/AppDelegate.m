//
//  AppDelegate.m
//  LayerUse_Me
//
//  Created by 吴狄 on 2017/7/4.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "AppDelegate.h"


static NSString *LayerUserTableViewCellID = @"LayerUserTableViewCellID";

@interface AppDelegate ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UITableViewController *tableVC;

@property (nonatomic)  NSMutableArray<NSMutableDictionary*> *data;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc]initWithFrame:UIScreen.mainScreen.bounds];
    

    
    _tableVC = [[UITableViewController alloc]initWithStyle:UITableViewStylePlain];

    _tableVC.edgesForExtendedLayout = UIRectEdgeNone;
    _tableVC.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:_tableVC];
    
    _tableVC.tableView.delegate = self;
    _tableVC.tableView.dataSource = self;
    
    self.window.rootViewController = nc;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyWindow];
    
    return YES;
}




-(NSMutableArray<NSMutableDictionary *> *)data{
    
    
    if (_data == nil) {
        _data = [NSMutableArray arrayWithArray:@[
                                                 @{
                                                    @"class":@"WDMaskLayerViewController",
                                                    @"name":@"Mask Layer"
                                                     },
                                                 @{
                                                     @"class":@"CAGradientLayerViewController",
                                                     @"name":@"Gradient Layer"
                                                     },
                                                 @{
                                                     @"class":@"CAGradientLayerMaskViewController",
                                                     @"name":@"Gradient Layer - Mask"
                                                     },
                                                 @{
                                                     @"class":@"CAShapeLayerViewController",
                                                     @"name":@"Shaper Layer"
                                                     },
                                                 @{
                                                     @"class":@"CAshapeLayerMaskViewController",
                                                     @"name":@"Shaper Layer - Mask"
                                                     },
                                                 @{
                                                     @"class":@"CustomLayerViewController",
                                                     @"name":@"Custom Layer"
                                                     },
                                                 ]];
    }
    
    return _data;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.data.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LayerUserTableViewCellID];
    
    if (cell == nil) {
        
        cell = [UITableViewCell new];
    }
    
    NSDictionary *dic = self.data[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",dic[@"name"]];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = self.data[indexPath.row];
    
    
    UIViewController *vc =  [[NSClassFromString(dic[@"class"]) alloc]init];
    vc.navigationItem.title = dic[@"name"];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.edgesForExtendedLayout = UIRectEdgeNone;

    [self.tableVC.navigationController pushViewController:vc animated:YES];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
