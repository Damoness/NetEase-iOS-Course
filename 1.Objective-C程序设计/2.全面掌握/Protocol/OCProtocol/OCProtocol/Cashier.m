//
//  Cashier.m
//  OCProtocol
//
//  Created by 吴狄 on 2017/4/19.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "Cashier.h"


@interface Cashier () <FruitHelper>


@property (nonatomic,strong) NSArray<Fruit *> *array;

@end


@implementation Cashier


-(instancetype)initWithFruits:(NSArray<Fruit *> *)fruits{
    
    self = [super init];
    
    if (self) {
        
        _array = fruits;
    }
    
    return self;
    
}


-(CGFloat)checkOut{
    
    CGFloat sum = 0.0;
    
    
//    for (int i = 0; i < [self.array count]; i++) {
//        
//        sum += [self.array[i] calculatePriceWithIndex:i];
//        
//    }
    
    
    for (Fruit *fruit in self.array) {
        
        //sum += [fruit calculatePriceWithFruitHelper:self];
        sum  +=[fruit calculatePriceWithDiscountHandler:^CGFloat(Fruit *fruit) {
            
            
            NSUInteger index =  [self.array indexOfObject:fruit];
            
            
            if (index == NSNotFound) {
                
                return 1.0;
            }
            
            index +=1;
            
            BOOL discount = NO;
            
            if (index % 3 ==0) {
                
                discount = YES;
                
            }else if ([@(index).stringValue rangeOfString:@"3"].location != NSNotFound){
                
                discount = YES;
                
            }
            
            if(discount){
                
                return 0.8;
                
            }else{
                
                return 1.0;
                
            }
            
            
        }];
    }
    
    return  sum;
    
    
}

-(CGFloat)getDiscountForFruit:(Fruit *)fruit{
    
   NSUInteger index =  [self.array indexOfObject:fruit];
    
    
    if (index == NSNotFound) {
        
        return 1.0;
    }
    
    index +=1;
    
    BOOL discount = NO;
    
    if (index % 3 ==0) {
        
        discount = YES;
        
    }else if ([@(index).stringValue rangeOfString:@"3"].location != NSNotFound){
        
        discount = YES;
        
    }
    
    if(discount){
        
        return 0.8;
        
    }else{
        
        return 1.0;
        
    }
}

@end
