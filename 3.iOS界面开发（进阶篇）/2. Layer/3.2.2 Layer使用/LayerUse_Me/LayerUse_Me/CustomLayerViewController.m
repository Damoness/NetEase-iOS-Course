//
//  CustomLayerViewController.m
//  LayerUse_Me
//
//  Created by 吴狄 on 2017/7/7.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "CustomLayerViewController.h"
#import "TestView.h"
@interface CustomLayerViewController ()

@end

@implementation CustomLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [self testDrawRect];
    
}

- (void)testDrawRect{
    
    
    TestView *view = [[TestView alloc]initWithFrame:CGRectMake(50, 50, 200, 200)];
    
    [self.view addSubview:view];
    
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
