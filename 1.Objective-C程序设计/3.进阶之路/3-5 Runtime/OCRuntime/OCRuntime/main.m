//
//  main.m
//  OCRuntime
//
//  Created by oldman on 9/10/16.
//
//

#import <Foundation/Foundation.h>

#include <objc/runtime.h>

@interface Fruit : NSObject
@property NSString* name;
@property CGFloat price;
@end

@implementation Fruit

@end

@interface NSObject (CustomDescription)
@end

@implementation NSObject (CustomDescription)

+ (void)load {
    Method m = class_getInstanceMethod([NSObject class], @selector(myDescription));
    Method m2 = class_getInstanceMethod([NSObject class], @selector(description));
    
    method_exchangeImplementations(m, m2);
    
    //NSStringFromRect(NSRect aRect)
    
    //NSStringFromRect(<#NSRect aRect#>)
}

- (NSString*)myDescription {
    NSMutableString* result = [NSMutableString string];
    
    unsigned int count = 0;
    objc_property_t* properties = class_copyPropertyList([Fruit class], &count);
    for (unsigned int i = 0; i < count; ++i) {
        objc_property_t property = properties[i];
        const char* cName = property_getName(property);
        NSString* name = [NSString stringWithUTF8String:cName];
        [result appendFormat:@"%@->%@, ", name, [self valueForKey:name]];
    }
    free(properties);
    
    NSLog(@"selector: %@", NSStringFromSelector(_cmd));
    return [NSString stringWithFormat:@"%@: %@", [self myDescription], result];
}
@end

int main(int argc, const char * argv[]) {
    
    Fruit* f = [[Fruit alloc] init];
    f.name = @"苹果";
    f.price = 1.5;
    
    NSLog(@"%@", [f description]);

    
    NSLog(@"%@", [f description]);
    
    
    return 0;
}
