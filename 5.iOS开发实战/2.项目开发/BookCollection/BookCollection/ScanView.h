//
//  ScanView.h
//  BookCollection
//
//  Created by 吴狄 on 2017/8/8.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanView : UIView


-(instancetype)initWithFrame:(CGRect)frame rectSize:(CGSize)size offsetY:(CGFloat)offset;


-(void)startAnimation;

-(void)stopAnimation;

@end
