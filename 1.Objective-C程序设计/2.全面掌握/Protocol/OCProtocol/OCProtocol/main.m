//
//  main.m
//  OCProtocol
//
//  Created by 吴狄 on 2017/4/19.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fruit.h"
#import "Cashier.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        
        NSMutableArray<Fruit*> *fruits = [NSMutableArray array];
        
        Fruit *fruit1 = [[Fruit alloc]initWithPrice:1.4];
        [fruits addObject:fruit1];
        
        [fruits addObject:[[Fruit alloc]initWithPrice:1.5] ];
        [fruits addObject:[[Fruit alloc]initWithPrice:2.5] ];
        [fruits addObject:[[Fruit alloc]initWithPrice:1.6] ];
        [fruits addObject:[[Fruit alloc]initWithPrice:1.7] ];
        [fruits addObject:[[Fruit alloc]initWithPrice:2.5] ];
        [fruits addObject:[[Fruit alloc]initWithPrice:1.1] ];
        [fruits addObject:[[Fruit alloc]initWithPrice:1.8] ];
        
        
        Cashier *cashier = [[Cashier alloc]initWithFruits:fruits];
        
        NSLog(@"金额:%@",@([cashier checkOut]));
        
        
        NSLog(@"Hello, World!");
        
        
        
        [fruits enumerateObjectsUsingBlock:^(Fruit * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
            
            
            
        }];
        
        
        Fruit *a = [[ Fruit alloc]initWithPrice:1.1];
        Fruit *b = [[Fruit alloc]initWithPrice:1.2];
        
        
//        
//        NSDictionary *dic = @{a:@(a.price),b:@(b.price)};
//        
//        a.price = 2;
//        NSLog(@"dic:%@",dic.allKeys);
//        
//       // a.copy;
        
        
        Fruit *c = a.copy;
    
        NSSet *set = [NSSet setWithObjects:a,b,c, nil];
        
        
        NSLog(@"set's count:%@",@(set.count));
        
        
        
    }
    return 0;
}
