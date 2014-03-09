//
//  CalendarDataSource.m
//  Calendar
//
//  Created by Ole Begemann on 29.07.13.
//  Copyright (c) 2013 Ole Begemann. All rights reserved.
//

#import "PKTAppDelegate.h"
#import "CalendarDataSource.h"
#import "PKTEventManager.h"
#import "PKTTaskScheduler.h"

@interface CalendarDataSource ()
@property (strong, nonatomic) NSMutableArray *events;
@property (strong, nonatomic) NSArray *openIntervals;
@property (strong, nonatomic) PKTTaskScheduler *scheduler;

@end

@implementation CalendarDataSource

- (void)scheduleTasks:(NSArray *)tasks
{
    self.openIntervals = [self.scheduler openTimeIntervalsBetweenEventsInArray:self.events];
    [self.events addObjectsFromArray:[self.scheduler packTasks:tasks intoIntervals:self.openIntervals]];
}

- (void)getUserEventsFromCalendar
{
    PKTEventManager *mgr = [[PKTEventManager alloc] init];
    self.events = [[mgr eventsForCurrentDay] mutableCopy];
}
- (NSArray *)getTasksToScheduleFromAppDelegate
{
    PKTAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    return delegate.taskList;
}
- (void)awakeFromNib
{
    _events = [[NSMutableArray alloc] init];
    _scheduler = [[PKTTaskScheduler alloc] init];

    [self getUserEventsFromCalendar];
}

#pragma mark - CalendarDataSource

// The layout object calls these methods to identify the events that correspond to
// a given index path or that are visible in a certain rectangle

- (id<CalendarEvent>)eventAtIndexPath:(NSIndexPath *)indexPath
{
    return self.events[indexPath.item];
}

//- (NSArray *)indexPathsOfEventsBetweenMinStartHour:(NSInteger)minStartHour maxStartHour:(NSInteger)maxStartHour
//{
//    NSMutableArray *indexPaths = [NSMutableArray array];
//    [self.events enumerateObjectsUsingBlock:^(id event, NSUInteger idx, BOOL *stop) {
//        if ([event startHour] >= minStartHour && [event startHour] <= maxStartHour)
//        {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
//            [indexPaths addObject:indexPath];
//        }
//    }];
//    return indexPaths;
//}

- (NSArray *)indexPathsOfEventsBetweenMinStartMinute:(NSInteger)minStartMinute maxStartMinute:(NSInteger)maxStartMinute
{
    NSMutableArray *indexPaths = [NSMutableArray array];
    [self.events enumerateObjectsUsingBlock:^(id event, NSUInteger idx, BOOL *stop) {
        if ([event startMinute] >= minStartMinute && [event startMinute] <= maxStartMinute)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
            [indexPaths addObject:indexPath];
        }
    }];
    return indexPaths;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.events count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<CalendarEvent> event = self.events[indexPath.item];
    CalendarEventCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CalendarEventCell" forIndexPath:indexPath];
    
    if (self.configureCellBlock) {
        self.configureCellBlock(cell, indexPath, event);
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    HeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    if (self.configureHeaderViewBlock) {
        self.configureHeaderViewBlock(headerView, kind, indexPath);
    }
    return headerView;
}

@end
