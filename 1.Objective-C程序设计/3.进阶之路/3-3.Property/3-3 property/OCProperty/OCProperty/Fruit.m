//
//  Fruit.m
//  OCProperty
//
//  Created by oldman on 9/10/16.
//
//

#import "Fruit.h"

@interface Fruit ()
@property CGFloat price;
@end

@implementation Fruit

- (instancetype)initWithPrice:(CGFloat)price {
    if (self = [super init]) {
        _price = price;
    }
    return self;
}

- (void)foo {
    self.price = 2.0;
}

@end
