//
//  AppDelegate.m
//  UITabbarController_Homework
//
//  Created by wd on 2017/5/30.
//  Copyright © 2017年 ditiy. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"
#import "UITabViewController.h"

#import "UITabBar+Badge.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:10]}            forState:UIControlStateNormal];
    
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:10]}            forState:UIControlStateSelected];
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window = [[UIWindow alloc]initWithFrame:UIScreen.mainScreen.bounds];
    
    
    
    
    
    UITabBarController *tabBarVC = [UITabViewController new];

    FirstViewController *vc1  = [FirstViewController new];
    
    SecondViewController *vc2 = [SecondViewController new];
    
    ThirdViewController *vc3 = [ThirdViewController new];
    
    FourthViewController *vc4 = [FourthViewController new];
    
    FifthViewController *vc5 = [FifthViewController new];
    
    
    
    
    UIImage *image1 = [UIImage imageNamed:@"tab_home"];
    UIImage *image2 = [UIImage imageNamed:@"tab_activity"];
    UIImage *image3 = [UIImage imageNamed:@"tab_sort"];
    UIImage *image4 = [UIImage imageNamed:@"tab_cart"];
    UIImage *image5 = [UIImage imageNamed:@"tab_mine"];

    
    UIImage *selectedImage1 = [[UIImage imageNamed:@"tab_home_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage2 = [[UIImage imageNamed:@"tab_activity_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage3 = [[UIImage imageNamed:@"tab_sort_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage4 = [[UIImage imageNamed:@"tab_cart_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage5 = [[UIImage imageNamed:@"tab_mine_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    
    UITabBarItem *item1 = [[UITabBarItem alloc]initWithTitle:@"首页" image:image1 selectedImage:selectedImage1];
    UITabBarItem *item2 = [[UITabBarItem alloc]initWithTitle:@"活动" image:image2 selectedImage:selectedImage2];
    UITabBarItem *item3 = [[UITabBarItem alloc]initWithTitle:@"分类" image:image3 selectedImage:selectedImage3];
    UITabBarItem *item4 = [[UITabBarItem alloc]initWithTitle:@"购物车" image:image4 selectedImage:selectedImage4];
    UITabBarItem *item5 = [[UITabBarItem alloc]initWithTitle:@"我的考拉" image:image5 selectedImage:selectedImage5];
    
    
    
    vc1.tabBarItem = item1;
    vc2.tabBarItem = item2;
    vc3.tabBarItem = item3;
    vc4.tabBarItem = item4;
    vc5.tabBarItem = item5;


    
    tabBarVC.viewControllers = @[vc1,vc2,vc3,vc4,vc5];
        
    
    [tabBarVC.tabBar setTintColor:[UIColor redColor]];
    
    [tabBarVC.tabBar showBadgeOnItemIndex:1];
    
    self.window.rootViewController = tabBarVC;
    [self.window makeKeyAndVisible];
    
    
    return YES;
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
