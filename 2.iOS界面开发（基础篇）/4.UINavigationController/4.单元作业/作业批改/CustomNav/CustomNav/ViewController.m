//
//  ViewController.m
//  CustomNav
//
//  Created by wtndcs on 16/7/31.
//  Modified by Zakari on 16/11/20.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
#import "searchView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"导航栏标题";

    UIBarButtonItem *QRcodeItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"codeicon"] style:UIBarButtonItemStylePlain target:self action:@selector(QRcode)];

  //View *view = [[[UINib nibWithNibName:@"View" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
  //[view.searchView setText:@"在千万海外商品中搜索"];
  //UIBarButtonItem *customItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    searchView *view = [[[UINib nibWithNibName:@"View" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    [view.Test setText:@""];
    [view.Test setBackgroundColor:[UIColor lightGrayColor]];
    UIBarButtonItem *customItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.leftBarButtonItems = @[QRcodeItem,customItem];
    UIBarButtonItem *talkItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"talk"] style:UIBarButtonItemStylePlain target:self action:@selector(talk)];
    self.navigationItem.rightBarButtonItem = talkItem;
    //     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBack"] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor lightGrayColor]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
//   [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
//    self.view.backgroundColor = [UIColor blueColor];
      self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.shadowImage = [UIImage imageNamed:@"navSep"];
//    
//    NSShadow *shadow = [NSShadow new];
//    [shadow setShadowColor: [UIColor colorWithWhite:0.0f alpha:0.750f]];
//    [shadow setShadowOffset: CGSizeMake(0.0f, 1.0f)];
//
//    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
//                                               [UIColor yellowColor],NSForegroundColorAttributeName,
//                                               shadow, NSShadowAttributeName, nil];
//
//    [self.navigationController.navigationBar setTitleTextAttributes:navbarTitleTextAttributes];
//    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:10 forBarMetrics:UIBarMetricsDefault];
//
//    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
//    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"imgBack"]];
//    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"imgBack"]];
//    [self.navigationController setNavigationBarHidden:YES];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
  return UIStatusBarStyleDefault;
}

- (IBAction)clickPushNext:(id)sender
{
    NextViewController *next = [[NextViewController alloc] init];
    [self.navigationController pushViewController:next animated:YES];
}

- (void)QRcode
{
    NSLog(@"Click to scan QRcode.\n");
}

- (void)talk
{
    NSLog(@"Click to talk.\n");
}

- (void)popOUt
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
