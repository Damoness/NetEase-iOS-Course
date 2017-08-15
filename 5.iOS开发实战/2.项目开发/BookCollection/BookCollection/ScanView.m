//
//  ScanView.m
//  BookCollection
//
//  Created by 吴狄 on 2017/8/8.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "ScanView.h"


@interface ScanView (){
    
    CGSize _size;
    CGFloat _offsetY;
    

    CGFloat minX,minY,maxX,maxY;
    
}


@property (nonatomic,strong) UIImageView *animationImage;



/**
 是否反向扫描
 */
@property (nonatomic,assign,getter=isAnimationReverse) BOOL animationReverse;


/**
 是否在动画
 */
@property (nonatomic,assign,getter=isAnimating) BOOL animating;

@end

@implementation ScanView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(context, 0, 0, 0, 0.4);
    
    
    //绘制半透明黑色背景
    CGContextFillRect(context, CGRectMake(0, 0, self.frame.size.width, minY));
    CGContextFillRect(context, CGRectMake(0, minY, minX, _size.height));
    CGContextFillRect(context, CGRectMake(maxX, minY, minX, _size.height));
    CGContextFillRect(context, CGRectMake(0, maxY, self.frame.size.width, minY -2 * _offsetY));
    
    
    
    //绘制中间的白色边框
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextStrokeRectWithWidth(context, CGRectMake(minX, minY, _size.width, _size.height), 0.5);
    
    CGContextStrokePath(context);
    
    
    //绘制中间区域的四个角落
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGFloat cornerLineLength = 9;
    CGFloat cornerLineThick = 1;
    CGContextSetLineWidth(context, cornerLineThick);
    
    
    //左上角
    CGContextMoveToPoint(context, minX - cornerLineThick + cornerLineLength, minY - cornerLineThick);
    CGContextAddLineToPoint(context, minX - cornerLineThick, minY - cornerLineThick);
    CGContextAddLineToPoint(context, minX- cornerLineThick, minY - cornerLineThick + cornerLineLength);
    
    //右上角
    CGContextMoveToPoint(context, maxX + cornerLineThick - cornerLineLength, minY - cornerLineThick);
    CGContextAddLineToPoint(context, maxX + cornerLineThick, minY - cornerLineThick);
    CGContextAddLineToPoint(context, maxX + cornerLineThick, minY - cornerLineThick + cornerLineLength);
    
    //左下角
    CGContextMoveToPoint(context, minX - cornerLineThick + cornerLineLength, maxY + cornerLineThick);
    CGContextAddLineToPoint(context, minX - cornerLineThick , maxY + cornerLineThick);
    CGContextAddLineToPoint(context, minX - cornerLineThick, maxY + cornerLineThick - cornerLineLength);
    
    //右下角
    CGContextMoveToPoint(context, maxX + cornerLineThick , maxY + cornerLineThick - cornerLineLength);
    CGContextAddLineToPoint(context, maxX + cornerLineThick,  maxY + cornerLineThick);
    CGContextAddLineToPoint(context, maxX + cornerLineThick - cornerLineLength , maxY + cornerLineThick);
    
    CGContextStrokePath(context);
    
    
}


-(void)startAnimation{
    
    
    if (self.isAnimating) {
        return;
    }
    
    self.animating = YES;
    
    [UIView animateWithDuration:3 delay:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
       
        if (self.animationReverse) {
            
            self.animationImage.frame = CGRectMake(minX, minY, _size.width, 1);
            
        }else{
            
             self.animationImage.frame = CGRectMake(minX, maxY, _size.width, 1);
            
        }
     
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            self.animationReverse = !self.isAnimationReverse;
            self.animating = NO;
            [self startAnimation];
            
        }else{
            
            [self stopAnimation];
            
        }
        
        
    }];
    
}


-(void)stopAnimation{
    
    
    [self.animationImage removeFromSuperview];
    self.animationReverse = NO;
    self.animating = NO;
    self.animationImage = nil;
    
    
}


-(UIImageView *)animationImage{
    
    if (_animationImage == nil) {
        
        _animationImage = [[UIImageView alloc]initWithFrame:CGRectMake(minX, minY, _size.width, 1) ];
        _animationImage.image = [UIImage imageNamed:@"scanner-line"];

        [self addSubview:_animationImage];

    }
    
    return _animationImage;
}

-(instancetype)initWithFrame:(CGRect)frame rectSize:(CGSize)size offsetY:(CGFloat)offset{
    
    self = [super initWithFrame:frame];
    
    if (self) {
     
        self.backgroundColor = [UIColor clearColor];
        
        _size = size;
        _offsetY = offset;
        
        minX = (self.frame.size.width - size.width)/2;
        minY = (self.frame.size.height - size.height)/2 + offset;
        maxX = minX + size.width;
        maxY = minY + size.height;
        
        [self addSubview:self.animationImage];
    }
    return self;
    
    
}

@end
