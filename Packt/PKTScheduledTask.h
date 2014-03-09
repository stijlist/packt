//
//  PKTScheduledTask.h
//  Packt
//
//  Created by Bert Muthalaly on 3/1/14.
//  Copyright (c) 2014 Bert Muthalaly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarEvent.h"

@interface PKTScheduledTask : NSObject <CalendarEvent>

-(id)initWithStartDate:(NSDate *)startDate andTimeInterval:(NSTimeInterval)timeInterval;

@end
