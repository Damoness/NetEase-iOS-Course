//
//  CPWaveLayer.m
//  CoreAnimationDemo3
//
//  Created by Chengyin on 16/8/7.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "CPWaveLayer.h"

static NSString * const kAmplitudeKey = @"amplitude";
static NSString * const kFrequencyKey = @"frequency";
static NSString * const kPhaseKey = @"phase";

@implementation CPWaveLayer
@dynamic amplitude;
@dynamic phase;
@dynamic frequency;

+ (NSArray *)customKeys
{
    static NSArray *__customKeys = nil;
    if (!__customKeys)
    {
        __customKeys = @[kAmplitudeKey,kFrequencyKey,kPhaseKey];
    }
    return __customKeys;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.fillColor = [UIColor clearColor].CGColor;
        self.lineWidth = 2;
    }
    return self;
}

- (void)drawCurveWithAmplitude:(CGFloat)amplitude phase:(CGFloat)phase frequency:(CGFloat)frequency
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    NSUInteger point = self.bounds.size.width;
    for (int x = 0; x < point; x++)
    {
        //y=Asin(ωx+φ)+k => y = amplitude * sin(frequency * x + phase) + view.Height / 2
        CGFloat y = amplitude * sin(frequency * x + phase) + self.bounds.size.height / 2;
        if (x == 0)
        {
            [path moveToPoint:CGPointMake(x, y)];
        }
        else
        {
            [path addLineToPoint:CGPointMake(x, y)];
        }
    }
    
    self.path = path.CGPath;
}

- (id<CAAction>)actionForKey:(NSString *)event
{
    if ([[[self class] customKeys] containsObject:event])
    {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:event];
        animation.fromValue = [[self presentationLayer] valueForKey:event];
        return animation;
    }
    else
    {
        return [super actionForKey:event];
    }
}

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([[self customKeys] containsObject:key])
    {
        return YES;
    }
    else
    {
        return [super needsDisplayForKey:key];
    }
}

- (void)display
{
    CGFloat amplitude = [(CPWaveLayer *)[self presentationLayer] amplitude];
    CGFloat phase = [(CPWaveLayer *)[self presentationLayer] phase];
    CGFloat frequency = [(CPWaveLayer *)[self presentationLayer] frequency];
    
    [self drawCurveWithAmplitude:amplitude phase:phase frequency:frequency];
}
@end
