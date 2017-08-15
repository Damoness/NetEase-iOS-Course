//
//  Source.h
//  OCKVC
//
//  Created by oldman on 9/10/16.
//
//

#import <Foundation/Foundation.h>

@interface Source : NSObject
@property NSString* province;
@property NSString* city;
@property NSString* county;

- (instancetype)initWithProvince:(NSString*)province city:(NSString*)city county:(NSString*)county;

@end