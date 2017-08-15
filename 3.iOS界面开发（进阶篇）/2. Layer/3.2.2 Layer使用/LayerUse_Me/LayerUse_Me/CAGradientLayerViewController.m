//
//  CAGradientLayerViewController.m
//  LayerUse_Me
//
//  Created by 吴狄 on 2017/7/5.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "CAGradientLayerViewController.h"

@interface CAGradientLayerViewController ()

@end

@implementation CAGradientLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    CAGradientLayer *gradientlayer = [CAGradientLayer layer];
    
    gradientlayer.frame = CGRectMake(100, 100, 150, 150);
    
    
    [gradientlayer setColors:@[(id)[UIColor redColor].CGColor,
                               (id)[UIColor greenColor].CGColor,
                               (id)[UIColor blueColor].CGColor
                               ]];
    
    [gradientlayer setLocations:@[@0.25,@0.5,@0.75]];
    
    [gradientlayer setStartPoint:CGPointMake(0, 0)];
    [gradientlayer setEndPoint:CGPointMake(1, 0)];
    
    [self.view.layer addSublayer:gradientlayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
