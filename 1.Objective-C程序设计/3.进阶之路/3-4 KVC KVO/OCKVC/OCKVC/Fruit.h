//
//  Fruit.h
//  OCKVC
//
//  Created by oldman on 9/10/16.
//
//

#import <Foundation/Foundation.h>

#import "Source.h"

@interface Fruit : NSObject
@property NSString* name;
@property CGFloat price;
@property Source* from;

- (instancetype)initWithDict:(NSDictionary*)dict;

@end
