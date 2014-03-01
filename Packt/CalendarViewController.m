//
//  CalendarViewController.m
//  Calendar
//
//  Created by Ole Begemann on 29.07.13.
//  Copyright (c) 2013 Ole Begemann. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarDataSource.h"
#import "CalendarEvent.h"
#import "HeaderView.h"
#import "PKTTaskScheduler.h"

@interface CalendarViewController ()

@property (strong, nonatomic) IBOutlet CalendarDataSource *calendarDataSource;
@property (strong, nonatomic) NSArray *tasks;
@property (strong, nonatomic) NSArray *openIntervals;
@property (strong, nonatomic) PKTTaskScheduler *scheduler;
@end

@implementation CalendarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Register NIB for supplementary views
    UINib *headerViewNib = [UINib nibWithNibName:@"HeaderView" bundle:nil];
    [self.collectionView registerNib:headerViewNib forSupplementaryViewOfKind:@"HourHeaderView" withReuseIdentifier:@"HeaderView"];
    
    // Define cell and header view configuration
    CalendarDataSource *dataSource = (CalendarDataSource *)self.collectionView.dataSource;
    //CalendarDataSource *dataSource = [[CalendarDataSource alloc] init];
    dataSource.configureCellBlock = ^(CalendarEventCell *cell, NSIndexPath *indexPath, id<CalendarEvent> event) {
        cell.titleLabel.text = event.title;
    };
    dataSource.configureHeaderViewBlock = ^(HeaderView *headerView, NSString *kind, NSIndexPath *indexPath) {
        if ([kind isEqualToString:@"HourHeaderView"]) {
            headerView.titleLabel.text = [NSString stringWithFormat:@"%2d:00", indexPath.item % 12 + 1];
        }
    };
}

- (void)scheduleTasks
{
    self.openIntervals = [self.scheduler openTimeIntervalsBetweenEventsInArray:self.calendarDataSource.events];
    [self.scheduler packTasks:self.tasks intoIntervals:self.openIntervals];
}

@end
