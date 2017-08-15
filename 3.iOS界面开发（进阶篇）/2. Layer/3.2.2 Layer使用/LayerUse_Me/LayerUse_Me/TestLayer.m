//
//  TestLayer.m
//  LayerUse_Me
//
//  Created by 吴狄 on 2017/7/7.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "TestLayer.h"

@implementation TestLayer



-(void)drawInContext:(CGContextRef)ctx{
    
    
    CGContextAddRect(ctx, CGRectMake(20, 20, 50, 50));
    
    CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
    
    CGContextFillPath(ctx);
    
    
}



@end
