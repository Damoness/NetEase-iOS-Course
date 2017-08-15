//
//  AppDelegate.m
//  NTESGesture2Demo
//
//  Created by jeunfung on 16/9/28.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "AppDelegate.h"
#import "GesturePriorityViewController.h"
#import "GestureConditionViewController.h"
#import "GestureSimultaneousViewController.h"
#import "GestureSystemViewController.h"
#import "CustomGestureViewController.h"
//#import "COSTouchVisualizerWindow.h"

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
    _tableVC.navigationItem.title = @"Gesture2 Demo";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_tableVC];
    
//    COSTouchVisualizerWindow *window = [[COSTouchVisualizerWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    window.touchVisualizerWindowDelegate = self;
//    self.window = window;
//    // Touch Color
//    [window setFillColor:[UIColor lightGrayColor]];
//    [window setStrokeColor:[UIColor grayColor]];
//    [window setTouchAlpha:0.4];
//    // Ripple Color
//    [window setRippleFillColor:[UIColor lightGrayColor]];
//    [window setRippleStrokeColor:[UIColor grayColor]];
//    [window setRippleAlpha:0.1];
//    
    
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
    return 5;
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
            title = @"Gesture - Priority";
            break;
        case 1:
            title = @"Gesture - Condition";
            break;
        case 2:
            title = @"Gesture - Simultaneous";
            break;
        case 3:
            title = @"Gesture - System";
            break;
        case 4:
            title = @"Gesture - Custom";
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
            targetVC = (UIViewController *)[[GesturePriorityViewController alloc] init];
            break;
        case 1:
            targetVC = (UIViewController *)[[GestureConditionViewController alloc] init];
            break;
        case 2:
            targetVC = (UIViewController *)[[GestureSimultaneousViewController alloc] init];
            break;
        case 3:
            targetVC = (UIViewController *)[[GestureSystemViewController alloc] init];
            break;
        case 4:
            targetVC = (UIViewController *)[[CustomGestureViewController alloc] init];
            break;
        default:
            break;
    }
    
    if (targetVC)
    {
        [_tableVC.navigationController pushViewController:targetVC animated:YES];
    }
    
}

//- (BOOL)touchVisualizerWindowShouldAlwaysShowFingertip:(COSTouchVisualizerWindow *)window {
//    return YES;  // Return YES to make the fingertip always display even if there's no any mirrored screen.
//    // Return NO or don't implement this method if you want to keep the fingertip display only when
//    // the device is connected to a mirrored screen.
//}
//
//- (BOOL)touchVisualizerWindowShouldShowFingertip:(COSTouchVisualizerWindow *)window
//{
//    return YES;
//}
//

@end
