//
//  PKTScheduledTask.m
//  Packt
//
//  Created by Bert Muthalaly on 3/1/14.
//  Copyright (c) 2014 Bert Muthalaly. All rights reserved.
//

#import "PKTScheduledTask.h"

@implementation PKTScheduledTask

-(PKTScheduledTask *)initWithStartDate:(NSDate *)startDate andTimeInterval:(NSTimeInterval)timeInterval;
{
    
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *eventStartComponents = [currentCalendar components:(NSHourCalendarUnit)
                                                                fromDate:startDate];
    
    self.startHour = [eventStartComponents hour];
    self.durationInHours = (NSUInteger)(timeInterval / (60 * 60)); // (time interval in seconds) / (seconds in an hour)
    return self;
}
@end
