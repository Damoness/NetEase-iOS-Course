//
//  TestView.m
//  NTESCALayerDemo
//
//  Created by lujunfeng on 16/7/11.
//  Copyright © 2016年 NetEase. All rights reserved.
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

+ (Class)layerClass
{
    return [TestLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}



@end
