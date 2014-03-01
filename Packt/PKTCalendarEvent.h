//
//  PKTCalendarEvent.h
//  Packt
//
//  Created by Bert Muthalaly on 3/1/14.
//  Copyright (c) 2014 Bert Muthalaly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarEvent.h"
#import <EventKit/EventKit.h>

@interface PKTCalendarEvent : NSObject <CalendarEvent>
@property (strong, nonatomic) EKEvent *event;
- (PKTCalendarEvent *) initWithEKEvent:(EKEvent *) event;
@end
