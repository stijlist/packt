//
//  PKTCalendarEvent.m
//  Packt
//
//  Created by Bert Muthalaly on 3/1/14.
//  Copyright (c) 2014 Bert Muthalaly. All rights reserved.
//

#import "PKTCalendarEvent.h"
#import <EventKit/EventKit.h>
@interface PKTCalendarEvent ()
@property EKEvent *event;
@end

@implementation PKTCalendarEvent
- (id)initWithEKEvent:(EKEvent *)event
{
    self = [super init];
    if (self) {
        _event = event;
    }

    return self;
}
- (NSString *)title
{
    return self.event.title;
}
- (NSInteger)startMinute
{
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *eventStartComponents = [currentCalendar components:(NSHourCalendarUnit|NSMinuteCalendarUnit)
                                                                fromDate:[self.event startDate]];
    
    return ([eventStartComponents hour]*60) + [eventStartComponents minute];
}
- (NSInteger)durationInMinutes
{
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *eventDurationComponents = [currentCalendar components:(NSHourCalendarUnit|NSMinuteCalendarUnit) fromDate:[self.event startDate] toDate:[self.event endDate] options:0];
    
    return ([eventDurationComponents hour]*60) + [eventDurationComponents minute];
}

- (NSDate *)startDate {
    return self.event.startDate;
}
- (NSDate *)endDate {
    return self.event.endDate;
}
@end
