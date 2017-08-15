//
//  NTESGradientLayerViewController.m
//  CALayerDemo2
//
//  Created by lujunfeng on 16/7/16.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "NTESGradientLayerViewController.h"

@interface NTESGradientLayerViewController ()

@end

@implementation NTESGradientLayerViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.navigationItem.title = @"Gradient Layer";
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(100, 100, 150, 150);
    
    [layer setColors:@[
                      (id)[UIColor yellowColor].CGColor,
                      (id)[UIColor greenColor].CGColor,
                      (id)[UIColor blueColor].CGColor
                      ]];
    
    [layer setLocations:@[@0.25, @0.5, @0.75]];
    [layer setStartPoint:CGPointMake(0, 0)];
    [layer setEndPoint:CGPointMake(1, 0)];

    //demo2
//    [layer setColors:@[(id)[UIColor yellowColor].CGColor,
//                      (id)[UIColor greenColor].CGColor]];
//    [layer setLocations:@[@0.25, @0.75]];
//    [layer setStartPoint:CGPointMake(0, 0)];
//    [layer setEndPoint:CGPointMake(0.5, 0.5)];
    
    
    [self.view.layer addSublayer:layer];
    
    
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
