//
//  main.m
//  OCKVC
//
//  Created by oldman on 9/10/16.
//
//

#import <Foundation/Foundation.h>

#import "Fruit.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray* array = [NSMutableArray array];
        {
            NSDictionary* dict = @{@"name" : @"苹果", @"price" : @1.5};
            Fruit* fruit = [[Fruit alloc] initWithDict:dict];
            [array addObject:fruit];
        }
        {
            NSDictionary* dict = @{@"name" : @"苹果", @"price" : @1};
            Fruit* fruit = [[Fruit alloc] initWithDict:dict];
            [array addObject:fruit];
        }
        {
            NSDictionary* dict = @{@"name" : @"苹果", @"price" : @2.5};
            Fruit* fruit = [[Fruit alloc] initWithDict:dict];
            [array addObject:fruit];
        }
        
//        CGFloat sum = 0;
//        for (Fruit* f in array) {
//            sum += f.price;
//        }
//        CGFloat avg = sum / array.count;
        
        CGFloat max = [[array valueForKeyPath:@"@max.price"] floatValue];
        
        NSLog(@"result: %@", @(max));

    }
    return 0;
}
