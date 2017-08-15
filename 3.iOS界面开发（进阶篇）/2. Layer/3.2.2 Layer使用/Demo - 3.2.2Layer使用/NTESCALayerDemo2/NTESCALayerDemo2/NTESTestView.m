//
//  NTESTestView.m
//  CALayerDemo2
//
//  Created by lujunfeng on 16/7/16.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "NTESTestView.h"
#import "NTESTestLayer.h"

@implementation NTESTestView

//demo2
//+ (Class)layerClass
//{
//    return [NTESTestLayer class];
//}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    CGContextAddRect(ctx, CGRectMake(50, 50, 100, 100));
    
    CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
    
    CGContextFillPath(ctx);
    
    //avoid using if not override
//    [self.layer drawInContext:ctx];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGContextAddRect(ctx, CGRectMake(50, 50, 100, 100));
    
    CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
    
    CGContextFillPath(ctx);

}

@end
