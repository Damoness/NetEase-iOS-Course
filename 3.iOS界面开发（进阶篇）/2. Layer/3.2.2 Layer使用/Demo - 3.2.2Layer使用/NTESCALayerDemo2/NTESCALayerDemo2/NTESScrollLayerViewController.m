//
//  NTESScrollLayerViewController.m
//  CALayerDemo2
//
//  Created by lujunfeng on 16/7/16.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "NTESScrollLayerViewController.h"

@interface NTESScrollLayerViewController ()
{
    CAScrollLayer *_scrollLayer;
}
@end

@implementation NTESScrollLayerViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.navigationItem.title = @"Scroll Layer";
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self testScrollLayer];
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
- (void)testScrollLayer
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"nature.jpg"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.frame = CGRectMake(0, 0, 150, 100);
    
    _scrollLayer = [CAScrollLayer layer];
    _scrollLayer.frame = CGRectMake(50, 50, 200, 200);
    _scrollLayer.backgroundColor = [UIColor grayColor].CGColor;
    _scrollLayer.scrollMode = kCAScrollBoth;
    
    [_scrollLayer addSublayer:imageView.layer];
    [self.view.layer addSublayer:_scrollLayer];
    
    //attach pan gesture recognizer
    UIPanGestureRecognizer *recognizer = nil;
    recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:recognizer];
}

- (void)pan:(UIPanGestureRecognizer *)gesture
{
    CGPoint translation = [gesture translationInView:self.view];
    CGPoint targetPoint = CGPointMake(_scrollLayer.bounds.origin.x - translation.x, _scrollLayer.bounds.origin.y - translation.y);
    [_scrollLayer scrollToPoint:targetPoint];
    [gesture setTranslation:CGPointZero inView:self.view];
}

@end
