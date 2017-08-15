//
//  Test.m
//  OCMemoryManagement
//
//  Created by oldman on 9/9/16.
//
//

#import "Test.h"

@implementation Test

- (instancetype)retain {
    NSLog(@"Test before retain: %@", @(self.retainCount));
    id result = [super retain];
    NSLog(@"Test after retain: %@", @(self.retainCount));
    return result;
}

- (oneway void)release
{
    NSLog(@"Test before release: %@", @(self.retainCount));
    [super release];
    NSLog(@"Test after release: %@", @(self.retainCount));
}

- (void)dealloc
{
    NSLog(@"Test: dealloc");
}

+ (Test*)getInstance {
    Test* result = [[Test alloc] init];
    return result;
}

@end
