//
//  PKTTask.h
//  Packt
//
//  Created by Gerald Patterson on 2/28/14.
//  Copyright (c) 2014 Bert Muthalaly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKTTask : NSObject <NSCoding>

@property NSString *title;
@property NSUInteger length;
- (NSTimeInterval) timeInterval;
@end
