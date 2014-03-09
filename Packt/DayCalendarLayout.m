//
//  WeekCalendarLayout.m
//  Calendar
//
//  Created by Ole Begemann on 29.07.13.
//  Copyright (c) 2013 Ole Begemann. All rights reserved.
//

#import "DayCalendarLayout.h"
#import "CalendarDataSource.h"
#import "CalendarEvent.h"

static const NSUInteger DaysPerWeek = 7;
static const NSUInteger HoursPerDay = 24;
static const CGFloat HorizontalSpacing = 10;
static const CGFloat HeightPerHour = 50;
static const CGFloat HeightPerMinute = HeightPerHour / 60;
static const CGFloat HourHeaderWidth = 100;

@interface DayCalendarLayout ()

@end

@implementation DayCalendarLayout

#pragma mark - UICollectionViewLayout Implementation

- (CGSize)collectionViewContentSize
{
    // Don't scroll horizontally
    CGFloat contentWidth = self.collectionView.bounds.size.width;

    // Scroll vertically to display a full day
    CGFloat contentHeight = (HeightPerHour * HoursPerDay);
    
    CGSize contentSize = CGSizeMake(contentWidth, contentHeight);
    return contentSize;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *layoutAttributes = [NSMutableArray array];

    // Cells
    NSArray *visibleIndexPaths = [self indexPathsOfItemsInRect:rect];
    for (NSIndexPath *indexPath in visibleIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }

    NSArray *hourHeaderViewIndexPaths = [self indexPathsOfHourHeaderViewsInRect:rect];
    for (NSIndexPath *indexPath in hourHeaderViewIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:@"HourHeaderView" atIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
    
    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarDataSource *dataSource = self.collectionView.dataSource;
    id<CalendarEvent> event = [dataSource eventAtIndexPath:indexPath];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = [self frameForEvent:event];
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:kind withIndexPath:indexPath];
    
    CGFloat totalWidth = [self collectionViewContentSize].width;
    if ([kind isEqualToString:@"HourHeaderView"]) {
        attributes.frame = CGRectMake(0, HeightPerHour * indexPath.item, totalWidth, HeightPerHour);
        attributes.zIndex = -10;
    }
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

#pragma mark - Helpers

- (NSArray *)indexPathsOfItemsInRect:(CGRect)rect
{
    NSInteger minVisibleMinute = [self minuteIndexFromYCoordinate:CGRectGetMinY(rect)];
    NSInteger maxVisibleMinute = [self minuteIndexFromYCoordinate:CGRectGetMaxY(rect)];
    
//    NSLog(@"rect: %@, days: %d-%d, hours: %d-%d", NSStringFromCGRect(rect), minVisibleDay, maxVisibleDay, minVisibleHour, maxVisibleHour);
    
    CalendarDataSource *dataSource = self.collectionView.dataSource;
    NSArray *indexPaths = [dataSource indexPathsOfEventsBetweenMinStartMinute:minVisibleMinute
                                                               maxStartMinute:maxVisibleMinute];
    return indexPaths;
}

- (NSInteger)hourIndexFromYCoordinate:(CGFloat)yPosition
{
    NSInteger hourIndex = MAX((NSInteger)0, (NSInteger)((yPosition) / HeightPerHour));
    return hourIndex;
}

- (NSInteger)minuteIndexFromYCoordinate:(CGFloat)yPosition
{
    NSInteger hourIndex = MAX((NSInteger)0, (NSInteger)((yPosition) / HeightPerMinute));
    return hourIndex;
}

- (NSArray *)indexPathsOfHourHeaderViewsInRect:(CGRect)rect
{
    if (CGRectGetMinX(rect) > HourHeaderWidth) {
        return [NSArray array];
    }
    
    NSInteger minHourIndex = [self hourIndexFromYCoordinate:CGRectGetMinY(rect)];
    NSInteger maxHourIndex = [self hourIndexFromYCoordinate:CGRectGetMaxY(rect)];
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSInteger idx = minHourIndex; idx <= maxHourIndex; idx++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}

- (CGRect)frameForEvent:(id<CalendarEvent>)event
{
    CGFloat totalWidth = [self collectionViewContentSize].width - HourHeaderWidth;
    CGFloat widthPerDay = totalWidth;

    CGRect frame = CGRectZero;
    frame.origin.x = HourHeaderWidth;
    frame.origin.y = HeightPerMinute * event.startMinute;
    frame.size.width = widthPerDay;
    frame.size.height = event.durationInMinutes * HeightPerMinute;
    
    frame = CGRectInset(frame, HorizontalSpacing/2.0, 0);
    return frame;
}

@end
