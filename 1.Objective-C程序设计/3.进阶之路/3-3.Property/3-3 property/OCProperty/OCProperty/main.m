//
//  main.m
//  OCProperty
//
//  Created by oldman on 9/10/16.
//
//

#import <Foundation/Foundation.h>
#import "Fruit.h"



@class B;

@interface A: NSObject

@property(retain) B *b;

@end


@implementation A

-(void)dealloc{
    
    [super dealloc];
    NSLog(@"%s",__FUNCTION__);
}

@end

@interface B : NSObject
@property (retain) A *a;
@end


@implementation B

-(void)dealloc{
    [super dealloc];
    NSLog(@"%s",__FUNCTION__);
}


@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        A *aA = [[A alloc]init];
        B *aB = [[B alloc]init];
        
        aA.b = aB;
        aB.a = aA;

        [aA release];
        [aB release];
        
    }
    return 0;
}
