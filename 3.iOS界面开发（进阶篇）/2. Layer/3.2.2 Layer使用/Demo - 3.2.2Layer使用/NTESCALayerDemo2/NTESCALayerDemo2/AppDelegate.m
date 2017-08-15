//
//  AppDelegate.m
//  NTESCALayerDemo2
//
//  Created by lujunfeng on 16/7/16.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "AppDelegate.h"
#import "NTESMaskLayerViewController.h"
#import "NTESGradientLayerViewController.h"
#import "NTESGradientLayerMaskViewController.h"
#import "NTESShapeLayerViewController.h"
#import "NTESShapeLayerMaskViewController.h"
#import "NTESShapeLayerAnimationViewController.h"
#import "NTESTextLayerViewController.h"
#import "NTESCustomLayerViewController.h"


@interface AppDelegate ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableViewController *_tableVC;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _tableVC = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    _tableVC.tableView.delegate = self;
    _tableVC.tableView.dataSource = self;
    _tableVC.edgesForExtendedLayout = UIRectEdgeNone;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_tableVC];
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];

    return YES;
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
}

#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSString *title;
    switch (indexPath.row) {
        case 0:
            title = @"Image mask";
            break;
        case 1:
            title = @"CAGradientLayer";
            break;
        case 2:
            title = @"CAGradientLayer - mask";
            break;
        case 3:
            title = @"CAShapeLayer";
            break;
        case 4:
            title = @"CAShapeLayer - mask";
            break;
        case 5:
            title = @"CAShapeLayer - animation";
            break;
        case 6:
            title = @"CATextLayer";
            break;
        case 7:
            title = @"Custom Layer";
            break;
        default:
            break;
    }
    cell.textLabel.text = title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *targetVC;
    switch (indexPath.row) {
        case 0:
            targetVC = (UIViewController *)[[NTESMaskLayerViewController alloc] init];
            break;
        case 1:
            targetVC = (UIViewController *)[[NTESGradientLayerViewController alloc] init];
            break;
        case 2:
            targetVC = (UIViewController *)[[NTESGradientLayerMaskViewController alloc] init];
            break;
        case 3:
            targetVC = (UIViewController *)[[NTESShapeLayerViewController alloc] init];
            break;
        case 4:
            targetVC = (UIViewController *)[[NTESShapeLayerMaskViewController alloc] init];
            break;
        case 5:
            targetVC = (UIViewController *)[[NTESShapeLayerAnimationViewController alloc] init];
            break;
        case 6:
            targetVC = (UIViewController *)[[NTESTextLayerViewController alloc] init];
            break;
        case 7:
            targetVC = (UIViewController *)[[NTESCustomLayerViewController alloc] init];
            break;
        default:
            break;
    }
    
    if (targetVC)
    {
        [_tableVC.navigationController pushViewController:targetVC animated:YES];
    }
    
}


@end
