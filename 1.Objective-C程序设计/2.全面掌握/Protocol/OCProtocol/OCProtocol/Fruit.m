//
//  Fruit.m
//  OCProtocol
//
//  Created by 吴狄 on 2017/4/19.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "Fruit.h"
#import "Cashier.h"
#import "FruitHelper.h"
@implementation Fruit

-(instancetype)initWithPrice:(CGFloat )price{
    
    self = [super init];
    
    if (self) {
        _price = price;
    }
    
    return self;
    
}


-(id)copyWithZone:(NSZone *)zone{
    
    
    Fruit *fruit = [Fruit new];
    
    fruit.price = self.price;
    
    return fruit;
    
    //return self;
    
}


-(BOOL)isEqual:(id)object{
    
    if (![object isKindOfClass:self.class]) {
        
        return NO;
        
    }
    
    
    if (self.price == [object price]) {
        
        return YES;
        
    }
    
    return NO;
    
}



-(NSUInteger)hash{

    return (NSUInteger)self.price;
}

-(CGFloat)calculatePriceWithIndex:(NSUInteger)index{
    
    BOOL discount = NO;
    
    if (index % 3 ==0) {
     
        discount = YES;
        
    }else if ([@(index).stringValue rangeOfString:@"3"].location != NSNotFound){
        
        discount = YES;
        
    }
    
    if(discount){
        
        return self.price * 0.8;
        
    }else{
        
        return self.price;
        
    }
    
}



- (NSString *)description
{
    return [NSString stringWithFormat:@"price:%@", @(self.price)];
}


-(CGFloat)calculatePriceWithFruitHelper:(id<FruitHelper>)helper{
    
    
    if ([helper respondsToSelector:@selector(getDiscountForFruit:)]) {
        
        return self.price * [helper getDiscountForFruit:self];
    }else{
        
        return self.price;
    }
    
    
    
    
}

-(CGFloat)calculatePriceWithDiscountHandler:(CGFloat(^)(Fruit *fruit))handler{
    
    return self.price * handler(self);
    
}



@end
