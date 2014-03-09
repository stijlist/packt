//
//  PKTScheduledTask.m
//  Packt
//
//  Created by Bert Muthalaly on 3/1/14.
//  Copyright (c) 2014 Bert Muthalaly. All rights reserved.
//

#import "PKTScheduledTask.h"

@implementation PKTScheduledTask
@synthesize startMinute = _startMinute;
@synthesize durationInMinutes = _durationInMinutes;
@synthesize title = _title;
@synthesize startHour = _startHour;
@synthesize durationInHours = _durationInHours;

-(id)initWithStartDate:(NSDate *)startDate andTimeInterval:(NSTimeInterval)timeInterval;
{
    
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *eventStartComponents = [currentCalendar components:(NSHourCalendarUnit|NSMinuteCalendarUnit)
                                                                fromDate:startDate];
    
    _startMinute = [eventStartComponents hour]*60 + [eventStartComponents minute];
    _durationInMinutes = (NSUInteger)(timeInterval / 60); // (time interval in seconds) / (seconds in an minute)
    return self;
}
@end
