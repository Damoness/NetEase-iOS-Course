//
//  ButtonHitTestViewController.m
//  EventUse_Me
//
//  Created by 吴狄 on 2017/7/7.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "ButtonHitTestViewController.h"
#import "ButtonHitTestView.h"
@interface ButtonHitTestViewController ()

@end

@implementation ButtonHitTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [self testButtonHitTest];
    
}


-(void)testButtonHitTest{
    
    
    ButtonHitTestView *button = [[ButtonHitTestView alloc]initWithFrame:CGRectMake(40, 40, 200, 200)];
    [self.view addSubview:button];
    
    
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
