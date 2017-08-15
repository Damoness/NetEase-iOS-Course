//
//  Fruit.h
//  OCProperty
//
//  Created by oldman on 9/10/16.
//
//

#import <Foundation/Foundation.h>

@interface Fruit : NSObject

- (instancetype)initWithPrice:(CGFloat)price;

@property (readonly) CGFloat price;

@end
