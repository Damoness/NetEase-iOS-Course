//
//  CPWaveLayer.h
//  CoreAnimationDemo3
//
//  Created by Chengyin on 16/8/7.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CPWaveLayer : CAShapeLayer

@property (nonatomic,assign) CGFloat amplitude;
@property (nonatomic,assign) CGFloat phase;
@property (nonatomic,assign) CGFloat frequency;

@end
