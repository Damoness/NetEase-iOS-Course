//
//  ViewController.m
//  kaolaNavigationBar
//
//  Created by jele lam on 3/6/2017.
//  Copyright © 2017年 jele lam. All rights reserved.
//

#import "KLViewController.h"
#import "KLTitleView.h"

@interface KLViewController ()

@end

@implementation KLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    KLTitleView *view = [[[UINib nibWithNibName:@"KLTitleView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    [view.scanButton addTarget:self action:@selector(scanButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [view.messageButton addTarget:self action:@selector(messageButtonPress) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = view;
    self.navigationItem.titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
}

- (void)scanButtonPress {
    NSLog(@"掃描按鈕被按下 😎😎😎😎");
}

- (void)messageButtonPress {
    NSLog(@"信息按鈕被按下 😎😎😎😎");

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonPress:(id)sender {
    
}


@end
