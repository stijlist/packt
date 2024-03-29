//
//  PKTEventManager.m
//  Packt
//
//  Created by Bert Muthalaly on 2/28/14.
//  Copyright (c) 2014 Bert Muthalaly. All rights reserved.
//

#import "PKTEventManager.h"

#import <EventKit/EventKit.h>
#import "PKTCalendarEvent.h"
#import "PKTInterval.h"

@implementation PKTEventManager
- (void) requestAccessToCalendarEvents
{
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        // handle access here
    }];
}
- (NSArray *)eventsForCurrentDay
{
    // TODO: call requestAccessToCalendarEvents if access hasn't yet been granted
    __block NSMutableArray *results = [[NSMutableArray alloc] init];
    // store events in NSArray, sequentially
    EKEventStore *store = [[EKEventStore alloc] init];

    if (![EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent]) {
        [self requestAccessToCalendarEvents];
    }

    EKCalendar *calendar = store.defaultCalendarForNewEvents;
    // get all events matching today
    NSDate *today = [[NSDate alloc] init];
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *todayComponents = [currentCalendar components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit)
                                                           fromDate:today];
    [todayComponents setHour:0];
    [todayComponents setMinute:0];
    [todayComponents setSecond:0];
    NSDate *todayStart = [currentCalendar dateFromComponents:todayComponents];
    [todayComponents setHour:23];
    [todayComponents setMinute:59];
    [todayComponents setSecond:59];
    NSDate *todayEnd = [currentCalendar dateFromComponents:todayComponents];
    NSPredicate *todayPredicate = [store predicateForEventsWithStartDate:todayStart
                                                                 endDate:todayEnd
                                                               calendars:@[calendar]];
    [store enumerateEventsMatchingPredicate:todayPredicate usingBlock:^void(EKEvent *event, BOOL *stop) {
        [results addObject: [[PKTCalendarEvent alloc] initWithEKEvent:event]];
    }];

    return results;
}
@end
