//
//  PKTTaskScheduler.h
//  Packt
//
//  Created by Bert Muthalaly on 2/28/14.
//  Copyright (c) 2014 Bert Muthalaly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKTTaskScheduler : NSObject
- (NSArray *)packTasks:(NSArray *)tasks intoIntervals:(NSArray *)intervals;
- (NSArray *)openTimeIntervalsBetweenEventsInArray:(NSArray *)events;

@end
