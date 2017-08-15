//
//  TestView.m
//  LayerIntroduction_Me
//
//  Created by 吴狄 on 2017/7/4.
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
    
    return  [TestLayer class];
    
}



@end
