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
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.length = [(NSNumber *)[aDecoder decodeObjectForKey:@"length"] integerValue];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:[NSNumber numberWithInt:self.length] forKey:@"author"];
}
@end
