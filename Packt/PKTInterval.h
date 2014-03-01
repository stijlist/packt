//
//  PKTInterval.h
//  Packt
//
//  Created by Bert Muthalaly on 2/28/14.
//  Copyright (c) 2014 Bert Muthalaly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKTTask.h"

@interface PKTInterval : NSObject
@property NSTimeInterval interval;
@property double remainingTime;
@property NSDate *startTime;
@property NSArray *tasksScheduled;
- (BOOL)scheduleTask:(PKTTask *) task;
@end
