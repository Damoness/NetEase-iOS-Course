//
//  ViewController.m
//  Demo1
//
//  Created by zjw on 2017/6/4.
//  Copyright © 2017年 zjw. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UISearchBarDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"扫一扫icon"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(scan)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"消息中心入口"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(message)];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
}

- (void)scan {
    NSLog(@"扫一扫");
}

- (void)message {
    NSLog(@"消息中心");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.navigationItem.titleView endEditing:YES];
    NSLog(@"%@", searchBar.text);
}

@end
