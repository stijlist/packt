//
//  PKTTaskScheduler.m
//  Packt
//
//  Created by Bert Muthalaly on 2/28/14.
//  Copyright (c) 2014 Bert Muthalaly. All rights reserved.
//

#import "PKTTaskScheduler.h"
#import "PKTInterval.h"

@implementation PKTTaskScheduler

- (NSArray *) firstFitDecreasingPackingOfTasks:(NSArray *)tasks intoIntervals:(NSArray *)intervals
{
    // sort tasks into decreasing order
    NSArray *sortedTasks = [tasks sortedArrayUsingSelector:NSSelectorFromString(@"interval")];
    NSDictionary *intervalsToRemainingTime = [self doubleKeyedDictionaryFromIntervalArray:intervals];
    for(PKTTask *task in tasks.reverseObjectEnumerator) {
        for (PKTInterval *interval in intervals) {
            // attempt to place task in interval
            if()
        }
    }
}

- (NSDictionary *) doubleKeyedDictionaryFromIntervalArray:(NSArray *)array
{
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
    for (PKTInterval *intervalInstance in array)
        [mutableDictionary setObject:[NSNumber numberWithDouble:[intervalInstance interval]]
                              forKey: intervalInstance];
    return (NSDictionary *)mutableDictionary;
}
@end
