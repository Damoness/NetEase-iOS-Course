//
//  NTESTestLayer.m
//  CALayerDemo2
//
//  Created by lujunfeng on 16/7/16.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "NTESTestLayer.h"
#import "NTESTestView.h"
#import <UIKit/UIKit.h>

@implementation NTESTestLayer

- (void)drawInContext:(CGContextRef)ctx
{
    CGContextAddRect(ctx, CGRectMake(50, 50, 100, 100));
    CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
    CGContextFillPath(ctx);
}

@end
