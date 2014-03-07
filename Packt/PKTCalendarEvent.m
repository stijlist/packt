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
- (PKTCalendarEvent *)initWithEKEvent:(EKEvent *)event
{
    self = [super init];
    if (self) {
        self.event = event;
    }

    return self;
}
- (NSString *)title
{
    return self.event.title;
}
- (NSInteger)startHour
{
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *eventStartComponents = [currentCalendar components:(NSHourCalendarUnit)
                                                           fromDate:[self.event startDate]];
    
    return [eventStartComponents hour];
}
- (NSInteger)durationInHours
{
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *eventStartComponents = [currentCalendar components:(NSHourCalendarUnit)
                                                           fromDate:[self.event startDate]];
    NSDateComponents *eventEndComponents = [currentCalendar components:NSHourCalendarUnit fromDate:[self.event endDate]];
    
    return [eventEndComponents hour] - [eventStartComponents hour];
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
    NSDateComponents *eventStartComponents = [currentCalendar components:(NSHourCalendarUnit|NSMinuteCalendarUnit)
                                                                fromDate:[self.event startDate]];
    NSDateComponents *eventEndComponents = [currentCalendar components:NSHourCalendarUnit fromDate:[self.event endDate]];
    // this doesn't work:
    /* return (([eventEndComponents hour]*60) + [eventEndComponents minute]) - (([eventStartComponents hour]*60) + [eventStartComponents minute]);

     */
    // but this does? what does the eventStart components minute call do?
    return (([eventEndComponents hour]*60) + [eventEndComponents minute]) - (([eventStartComponents hour]*60) + [eventStartComponents minute]);
}

- (NSDate *)startDate {
    return self.event.startDate;
}
- (NSDate *)endDate {
    return self.event.endDate;
}
@end
