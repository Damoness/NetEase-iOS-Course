//
//  Fruit.h
//  OCProtocol
//
//  Created by 吴狄 on 2017/4/19.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Cashier;
@class FruitHelper;

@interface Fruit : NSObject<NSCopying>


@property (nonatomic) CGFloat price;


-(instancetype)initWithPrice:(CGFloat )price;


//-(CGFloat)calculatePriceWithIndex:(NSUInteger)index;


-(CGFloat)calculatePriceWithFruitHelper:(FruitHelper *)helper;


-(CGFloat)calculatePriceWithDiscountHandler:(CGFloat(^)(Fruit *fruit))handler;


@end
