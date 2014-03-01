//
//  PKTTask.m
//  Packt
//
//  Created by Gerald Patterson on 2/28/14.
//  Copyright (c) 2014 Bert Muthalaly. All rights reserved.
//

#import "PKTTask.h"

@implementation PKTTask

- (NSTimeInterval) timeInterval
{
    return (NSTimeInterval)self.length * 60;
}
@end
