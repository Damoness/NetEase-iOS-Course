//
//  UIImage+image.m
//  UIViewAnimationDemo_Me
//
//  Created by Damoness on 2017/11/18.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "UIImage+image.h"
#import <objc/runtime.h>
@implementation UIImage (image)

+(void)load{
    
    
    Method imageNamed = class_getClassMethod(self, @selector(imageNamed:));
    
    Method ln_imageNamed = class_getClassMethod(self, @selector(ln_imageNamed:));
    
    method_exchangeImplementations(imageNamed, ln_imageNamed);
    
}

+(instancetype)ln_imageNamed:(NSString *)name{
    
    UIImage *image = [UIImage ln_imageNamed:name];
    
    if (image) {
        
        NSLog(@"runtime添加额外功能--加载成功");
        
    }else{
        
        NSLog(@"runtime添加额外功能--加载失败");
    }
    
    return image;
}

@end
