//
//  Source.m
//  OCKVC
//
//  Created by oldman on 9/10/16.
//
//

#import "Source.h"

@implementation Source

- (instancetype)initWithProvince:(NSString*)province city:(NSString*)city county:(NSString*)county {
    if (self = [super init]) {
        _province = province;
        _city = city;
        _county = county;
    }
    return self;
}

@end
