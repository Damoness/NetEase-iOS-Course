//
//  NTESCustomLayerViewController.m
//  CALayerDemo2
//
//  Created by lujunfeng on 16/7/16.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "NTESCustomLayerViewController.h"
#import "NTESTestLayer.h"
#import "NTESTestView.h"

@interface LayerDelegate : NSObject

@end

@implementation LayerDelegate

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGContextAddRect(ctx, CGRectMake(50, 50, 100, 100));
    CGContextSetRGBFillColor(ctx, 0, 1, 0, 1);
    CGContextFillPath(ctx);
}

@end


@interface NTESCustomLayerViewController ()
{
    LayerDelegate *_layerDelegate;
}
@end

@implementation NTESCustomLayerViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.navigationItem.title = @"Custom Layer";
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self testSubclassLayer];
    
//    [self testLayerDelegate];
    
    [self testViewDrawRect];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testSubclassLayer
{
    NTESTestLayer *testLayer = [NTESTestLayer layer];
    testLayer.backgroundColor = [UIColor orangeColor].CGColor;
    testLayer.frame = CGRectMake(10, 10, 200, 200);
    [self.view.layer addSublayer:testLayer];
    
    [testLayer setNeedsDisplay];
}

- (void)testLayerDelegate
{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    layer.frame = CGRectMake(10, 10, 200, 200);
    [self.view.layer addSublayer:layer];

    _layerDelegate = [[LayerDelegate alloc] init];
    layer.delegate = _layerDelegate;
    [layer setNeedsDisplay];
}

- (void)testViewDrawRect
{
    NTESTestView *testView = [[NTESTestView alloc] init];
    [self.view addSubview:testView];
    
    testView.frame = CGRectMake(10, 10, 200, 200);
    testView.layer.backgroundColor = [UIColor orangeColor].CGColor;
    testView.opaque = NO;
    [testView.layer setNeedsDisplay];
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
