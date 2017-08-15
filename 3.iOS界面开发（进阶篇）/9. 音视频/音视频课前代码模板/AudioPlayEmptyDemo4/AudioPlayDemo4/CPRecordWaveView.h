//
//  CPRecordWaveView.h
//  CoreAnimationDemo3
//
//  Created by Chengyin on 16/8/7.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPRecordWaveView : UIView

@property (nonatomic,strong) UIColor *color;
@property (nonatomic,assign) float power;

- (void)start;
- (void)stop;
@end
