//
//  PKTEventManager.h
//  Packt
//
//  Created by Bert Muthalaly on 2/28/14.
//  Copyright (c) 2014 Bert Muthalaly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKTEventManager : NSObject
- (NSArray *)eventsForCurrentDay;
- (NSArray *)openTimeIntervalsBetweenEventsInArray:(NSArray *)events;
@end
