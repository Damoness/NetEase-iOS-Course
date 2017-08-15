//
//  main.m
//  OCMemoryManagement
//
//  Created by oldman on 9/9/16.
//
//

#import <Foundation/Foundation.h>

#import "Test.h"

int main(int argc, const char * argv[]) {
    
    @autoreleasepool {
        Test* a = [Test getInstance];
        
        
       [a retain];
       [a release];
        
        NSLog(@"main before drain");
    }
    NSLog(@"main after drain");
    return 0;
}
