//
//  AppDelegate.m
//  NTESTouch2Demo
//
//  Created by jeunfung on 16/8/5.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "AppDelegate.h"
#import "ButtonHitTestViewController.h"
#import "ButtonPointInsideViewController.h"
#import "ButtonSubViewOutsideViewController.h"
#import "KeyboardViewController.h"
#import "TestWindow.h"

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
    _tableVC.navigationItem.title = @"Touch2 Demo";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_tableVC];
    
    TestWindow *testWindow = [[TestWindow alloc] init];
    self.window = testWindow;
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
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
    return 4;
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
            title = @"Button - hitTest";
            break;
        case 1:
            title = @"Button - pointInside";
            break;
        case 2:
            title = @"Button - subView outside";
            break;
        case 3:
            title = @"keyboard";
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
            targetVC = (UIViewController *)[[ButtonHitTestViewController alloc] init];
            break;
        case 1:
            targetVC = (UIViewController *)[[ButtonPointInsideViewController alloc] init];
            break;
        case 2:
            targetVC = (UIViewController *)[[ButtonSubViewOutsideViewController alloc] init];
            break;
        case 3:
            targetVC = (UIViewController *)[[KeyboardViewController alloc] init];
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
