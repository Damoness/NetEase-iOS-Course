//
//  CustomGestureRecognizer.m
//  NTESGesture2Demo
//
//  Created by jeunfung on 16/10/7.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "CustomGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
#import <objc/runtime.h>

@interface UITouch(BeginPoint)
@property (nonatomic, assign) CGPoint testCustomTouchBeginPoint;
@end

@implementation UITouch(BeginPoint)

- (void)setTestCustomTouchBeginPoint:(CGPoint)testCustomTouchBeginPoint
{
    NSString *string = NSStringFromCGPoint(testCustomTouchBeginPoint);
    objc_setAssociatedObject(self, @"testCustomTouchBeginPoint", string, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGPoint)testCustomTouchBeginPoint
{
    NSString *string = objc_getAssociatedObject(self, @"testCustomTouchBeginPoint");
    if (!string) {
        return CGPointZero;
    }
    CGPoint point = CGPointFromString(string);
    return point;
}

@end


@implementation CustomGestureRecognizer
{
    id _testTarget;
    SEL _testAction;
}

- (instancetype)initWithTarget:(id)target action:(SEL)action
{
    self = [super initWithTarget:target action:action];
    if (self)
    {
        _testTarget = target;
        _testAction = action;
        
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    for (UITouch *touch in touches) {
        touch.testCustomTouchBeginPoint = [touch locationInView:self.view];
    }
    
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (touches.count == 3)
    {
        BOOL allTestPass = YES;
        for (UITouch *touch in touches)
        {
            CGPoint currentPoint = [touch locationInView:self.view];
            CGFloat touchMovedY = currentPoint.y - touch.testCustomTouchBeginPoint.y;
            CGFloat touchMovedX = currentPoint.x - touch.testCustomTouchBeginPoint.x;
            if (!(ABS(touchMovedX) > 100 || ABS(touchMovedY) > 100))
            {
                allTestPass = NO;
                break;
            }
        }
        
        if (allTestPass)
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            if ([_testTarget respondsToSelector:_testAction])
            {
                [_testTarget performSelector:_testAction withObject:self];
            }
#pragma clang diagnostic pop
            
        }
        
    }
    
    
    
    
    [super touchesMoved:touches withEvent:event];
}


@end
