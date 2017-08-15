//
//  ViewController.m
//  NavControllerDemo
//
//  Created by Ashley Han on 27/1/2017.
//  Copyright © 2017 netease. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "TitleView.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navScan"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClicked)];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navShare"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClicked)];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.navigationItem.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    
    TitleView *titleView = [[[NSBundle mainBundle] loadNibNamed:@"TitleView" owner:nil options:nil] firstObject];
    titleView.frame = self.navigationItem.titleView.frame;
    titleView.layer.masksToBounds = YES;
    titleView.layer.cornerRadius = 6.0;
    titleView.layer.borderWidth = 1.0;
    titleView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.navigationItem.titleView addSubview:titleView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gotoNextClick:(id)sender {
    SecondViewController *second = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:second animated:YES];
}

- (void)leftButtonClicked {
    NSLog(@"left button is clicked");
}

- (void)rightButtonClicked {
    NSLog(@"right button is clicked");
}

@end
