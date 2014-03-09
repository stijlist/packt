//
//  PKTTaskScheduler.m
//  Packt
//
//  Created by Bert Muthalaly on 2/28/14.
//  Copyright (c) 2014 Bert Muthalaly. All rights reserved.
//

#import "PKTTaskScheduler.h"
#import "PKTInterval.h"
#import "PKTTask.h"
#import "PKTScheduledTask.h"
#import "PKTCalendarEvent.h"

@implementation PKTTaskScheduler

- (NSArray *)packTasks:(NSArray *)tasks intoIntervals:(NSArray *)intervals
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    // *** implementation of first fit decreasing bin packing algorithm
    // sort tasks by estimated time interval required
    NSArray *sortedTasks = [tasks sortedArrayUsingSelector:NSSelectorFromString(@"timeInterval")];
    
    for(PKTTask *task in sortedTasks.reverseObjectEnumerator) {
        for (PKTInterval *interval in intervals) {
            // if the task can be scheduled, schedule and stop searching
            if([interval scheduleTask:task]) {
                break;
                PKTScheduledTask *scheduledTask = [[PKTScheduledTask alloc] init];
                [results addObject:[scheduledTask initWithStartDate:interval.startTime andTimeInterval:interval.interval]];
            }
        }
    }
    return results;
    
}

- (NSArray *)openTimeIntervalsBetweenEventsInArray:(NSArray *)events
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    PKTCalendarEvent *lastEvent;
    for (PKTCalendarEvent *event in events) {
        if (lastEvent) {
            PKTInterval *interval = [[PKTInterval alloc] init];
            interval.startTime = lastEvent.endDate;
            interval.interval = [event.startDate timeIntervalSinceDate: lastEvent.endDate];
            [results addObject: interval];
        }
        lastEvent = event;
    }
    return results;
}

@end
