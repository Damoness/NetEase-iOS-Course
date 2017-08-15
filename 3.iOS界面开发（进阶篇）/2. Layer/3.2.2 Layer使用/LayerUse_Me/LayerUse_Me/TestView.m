//
//  TestView.m
//  LayerUse_Me
//
//  Created by 吴狄 on 2017/7/7.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "TestView.h"
#import "TestLayer.h"
@implementation TestView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+(Class)layerClass{
    
    
    return [TestLayer class];
    
}


-(void)drawRect:(CGRect)rect{
 
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddRect(context, CGRectMake(20, 20, 50, 50));
    
    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
    
    CGContextFillPath(context);
    
    
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    
    
    CGContextAddRect(ctx, CGRectMake(20, 20, 50, 50));
    
    CGContextSetRGBFillColor(ctx, 0, 1, 0, 1);
    
    CGContextFillPath(ctx);
    
    
}

@end
