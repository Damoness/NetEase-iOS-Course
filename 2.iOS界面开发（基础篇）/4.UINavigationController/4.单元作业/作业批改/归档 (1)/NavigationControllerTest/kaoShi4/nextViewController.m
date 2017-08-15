//
//  nextViewController.m
//  kaoShi4
//
//  Created by CyouGuang on 17/2/5.
//  Copyright © 2017年 CyouGuang. All rights reserved.
//

#import "nextViewController.h"

@interface nextViewController ()

@end

@implementation nextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navShare"] style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"imgBack"] style:UIBarButtonItemStylePlain target:self action:@selector(Back)];
    UIBarButtonItem *leftItem2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navClose"] style:UIBarButtonItemStyleDone target:self action:@selector(Back)];
    
    self.navigationItem.rightBarButtonItems = @[rightItem];
    self.navigationItem.leftBarButtonItems = @[leftItem,leftItem2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)Back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
