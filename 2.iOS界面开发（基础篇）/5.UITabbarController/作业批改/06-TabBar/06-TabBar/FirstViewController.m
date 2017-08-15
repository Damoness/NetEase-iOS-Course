//
//  FirstViewController.m
//  06-TabBar
//
//  Created by 苗冬 on 2017/5/30.
//  Copyright © 2017年 苗冬. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tabBarItem.titlePositionAdjustment = UIOffsetMake(-10, -10);
    NSShadow *shadow = [NSShadow new];
    [shadow setShadowOffset:CGSizeMake(10, 10)];
    [shadow setShadowColor:[UIColor colorWithWhite:0.0f alpha:0.75f]];
    [shadow setShadowBlurRadius:5.0f];
    NSDictionary *navBarTitleAttributesString = @{NSForegroundColorAttributeName:[UIColor redColor]};
    [self.tabBarItem setTitleTextAttributes:navBarTitleAttributesString forState:UIControlStateNormal];
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




@end
