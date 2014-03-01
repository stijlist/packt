//
//  PKTInterval.m
//  Packt
//
//  Created by Bert Muthalaly on 2/28/14.
//  Copyright (c) 2014 Bert Muthalaly. All rights reserved.
//

#import "PKTInterval.h"

@implementation PKTInterval
- (BOOL)scheduleTask:(PKTTask *)task {
    if (self.remainingTime >= task.timeInterval) {
        NSMutableArray *arr = [self.tasksScheduled mutableCopy];
        [arr addObject:task];
        self.tasksScheduled = [NSArray arrayWithArray:arr];
        self.remainingTime -= task.timeInterval;
        return YES;
    }
    return NO;
}
@end
