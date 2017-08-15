//
//  FruitHelper.h
//  OCProtocol
//
//  Created by 吴狄 on 2017/4/19.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Fruit;

@protocol FruitHelper <NSObject>


-(CGFloat)getDiscountForFruit:(Fruit *)fruit;


@end
