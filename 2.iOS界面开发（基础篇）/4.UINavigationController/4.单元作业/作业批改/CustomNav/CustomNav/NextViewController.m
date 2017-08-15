//
//  NextViewController.m
//  CustomNav
//
//  Created by wtndcs on 16/7/31.
//  Modified by Zakari on 16/11/20.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController () <UIGestureRecognizerDelegate>

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"美食-饮料清仓专场";
    self.view.backgroundColor = [UIColor whiteColor];
    //self.navigationController.navigationBar.barTintColor= [UIColor whiteColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *negSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negSpaceItem.width = -10;
   
    UIBarButtonItem *leftSpaceItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"imgBack"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navClose"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
    self.navigationItem.leftBarButtonItems = @[negSpaceItem, leftSpaceItem, closeItem];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navShare"] style:UIBarButtonItemStylePlain target:self action:@selector(navShare)];
    self.navigationItem.rightBarButtonItem = rightItem;


    //    UIBarButtonItem *leftBackItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"imgBack"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
//    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
//    customView.backgroundColor = [UIColor yellowColor];
//    UIBarButtonItem *customItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    
//    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navClose"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //self.navigationItem.leftBarButtonItems = @[leftBackItem,  closeItem];
    
    //self.navigationItem.hidesBackButton = YES;
    
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navShare"] style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.rightBarButtonItems = @[rightItem];
    
//    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
//    titleView.backgroundColor = [UIColor blueColor];
    //self.navigationItem.titleView = titleView;
    //self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//    if (self.navigationController.interactivePopGestureRecognizer.delegate) {
//        self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    }
    
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navShare
{
    NSLog(@"Click to share something.\n");
}

@end
