//
//  PKTCalendarEvent.m
//  Packt
//
//  Created by Bert Muthalaly on 3/1/14.
//  Copyright (c) 2014 Bert Muthalaly. All rights reserved.
//

#import "PKTCalendarEvent.h"

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
@end
