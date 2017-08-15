//
//  ViewController.m
//  kaoShi4
//
//  Created by CyouGuang on 17/2/5.
//  Copyright © 2017年 CyouGuang. All rights reserved.
//

#import "ViewController.h"
#import "nextViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *barTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dialog"] style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"qr_code"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItems = @[rightItem];
    self.navigationItem.leftBarButtonItems = @[leftItem];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nextPage:(id)sender {
    nextViewController *next = [[nextViewController alloc] init];
    [self.navigationController pushViewController:next animated:YES];
}


@end
