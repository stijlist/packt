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
- (NSDictionary *) dictionaryRepresentation
{
    return @{@"title": self.title, @"length": [NSNumber numberWithInt: self.length]};
}
- (id) initFromDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.length = [(NSNumber *)[dict objectForKey:@"length"] integerValue];
        self.title = (NSString *)[dict objectForKey:@"title"];
    }
    return self;
}
@end
