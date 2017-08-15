//
//  NTESTextLayerViewController.m
//  CALayerDemo2
//
//  Created by lujunfeng on 16/7/16.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "NTESTextLayerViewController.h"
#import <CoreText/CTStringAttributes.h>

@interface NTESTextLayerViewController ()

@end

@implementation NTESTextLayerViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.navigationItem.title = @"Text Layer";
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self testTextLayer];
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

- (void)testTextLayer
{
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.backgroundColor = [UIColor orangeColor].CGColor;
    textLayer.wrapped = YES;
    textLayer.alignmentMode = kCAAlignmentLeft;
    
    //font
    UIFont *font = [UIFont systemFontOfSize:12];
    CGFontRef fontRef = CGFontCreateWithFontName((__bridge CFStringRef)font.fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);//这里注意
    
    textLayer.frame = CGRectMake(50, 50, 200, 200);
    [self.view.layer addSublayer:textLayer];
    
    NSString *text = @"它聪明、熟悉每个用户的喜好，从海量音乐中挑选出你可能喜欢的音乐。它通过你每一次操作来记录你的口味。你提供给云音乐的信息越多，它就越了解你的音乐喜好。";
    
    textLayer.string = text;
    
    //rich text
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
    [string addAttribute:(NSString *)kCTForegroundColorAttributeName
                   value:(__bridge id)[UIColor yellowColor].CGColor
                   range:NSMakeRange(1, 2)];
    
    [string addAttribute:(NSString *)kCTFontAttributeName
                   value:[UIFont fontWithName:@"Arial" size:20]
                   range:NSMakeRange(1, 2)];
    
    NSDictionary *attrs = @{(__bridge id)kCTUnderlineStyleAttributeName:@(kCTUnderlineStyleSingle),
                            (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor blueColor].CGColor};
    [string setAttributes:attrs range:NSMakeRange(text.length - 5, 4)];
    
    textLayer.string = string;

}


@end
