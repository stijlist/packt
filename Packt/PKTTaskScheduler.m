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
#import "PKTCalendarEvent.h"
#import <EventKit/EventKit.h>

@implementation PKTTaskScheduler

- (void)packTasks:(NSArray *)tasks intoIntervals:(NSArray *)intervals
{
    // implementation of first fit decreasing bin packing algorithm
    // sort tasks by estimated time interval required
    NSArray *sortedTasks = [tasks sortedArrayUsingSelector:NSSelectorFromString(@"interval")];
    
    for(PKTTask *task in sortedTasks.reverseObjectEnumerator) {
        for (PKTInterval *interval in intervals) {
            // if the task can be scheduled, schedule and stop searching
            if([interval scheduleTask:task]) {
                break;
            }
        }
    }
}

// TODO refactor PKTCalendarEvent so that it abstracts away access to its internal EKEvent, remove event.event calls
- (NSArray *)openTimeIntervalsBetweenEventsInArray:(NSArray *)events
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    PKTCalendarEvent *lastEvent;
    for (PKTCalendarEvent *event in events) {
        if (lastEvent) {
            PKTInterval *interval = [[PKTInterval alloc] init];
            interval.startTime = lastEvent.event.endDate;
            interval.interval = [event.event.startDate timeIntervalSinceDate: lastEvent.event.endDate];
            [results addObject: interval];
        }
        lastEvent = event;
    }
    return results;
}

@end
