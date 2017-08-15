//
//  CPRecordWaveView.m
//  CoreAnimationDemo3
//
//  Created by Chengyin on 16/8/7.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "CPRecordWaveView.h"
#import "CPWaveLayer.h"

@interface CPRecordWaveView ()
{
    NSArray *_waves;
    NSTimer *_timer;
}
@end

@implementation CPRecordWaveView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CPWaveLayer *wave1 = [CPWaveLayer layer];
        wave1.frequency = 0.15;
        [self.layer addSublayer:wave1];
        
        CPWaveLayer *wave2 = [CPWaveLayer layer];
        wave2.frequency = 0.05;
        wave2.phase = M_PI;
        [self.layer addSublayer:wave2];
        
        CPWaveLayer *wave3 = [CPWaveLayer layer];
        wave3.frequency = 0.05;
        wave3.phase = M_PI_2;
        [self.layer addSublayer:wave3];
        
        _waves = @[wave1,wave2,wave3];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (CALayer *wave in _waves)
    {
        wave.frame = self.bounds;
    }
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    for (CPWaveLayer *layer in _waves)
    {
        NSUInteger index = [_waves indexOfObject:layer] + 1;
        layer.strokeColor = [_color colorWithAlphaComponent:1.0f / index].CGColor;
    }
}

- (void)setPower:(float)power
{
    _power = power;
    for (CPWaveLayer *wave in _waves)
    {
        NSUInteger index = [_waves indexOfObject:wave] + 1;
        wave.amplitude = index * 30 * _power;
    }
}

- (void)timerInvoke:(NSTimer *)timer
{
    for (CPWaveLayer *wave in _waves)
    {
        NSUInteger index = [_waves indexOfObject:wave] + 1;
        wave.phase = wave.phase - 1 -index * 0.1;
    }
}

- (void)start
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerInvoke:) userInfo:nil repeats:YES];
}

- (void)stop
{
    [_timer invalidate];
    self.power = 0;
}
@end
