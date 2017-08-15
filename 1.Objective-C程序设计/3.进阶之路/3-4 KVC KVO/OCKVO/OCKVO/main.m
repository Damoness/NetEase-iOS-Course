//
//  main.m
//  OCKVO
//
//  Created by oldman on 9/10/16.
//
//

#import <Foundation/Foundation.h>

#import "Displayer.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Displayer* displayer = [[Displayer alloc] init];
        [displayer download];
    }
    return 0;
}
