//
//  PacktTests.m
//  PacktTests
//
//  Created by Bert Muthalaly on 2/28/14.
//  Copyright (c) 2014 Bert Muthalaly. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EventKit/EventKit.h>
#import "PKTEventManager.h"
#import "PKTInterval.h"
#import "PKTTaskScheduler.h"

@interface PacktTests : XCTestCase
@property PKTEventManager *eventManager;
@property PKTTaskScheduler *scheduler;
@property NSArray *events;
@property NSArray *tasks;
@end

@implementation PacktTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.eventManager = [[PKTEventManager alloc] init];
    self.scheduler = [[PKTTaskScheduler alloc] init];
    
    // NOTE: this method is not designed for hardcoded fixtures and I know that.
    // I'm hardcoding them for now, and I will cross the scalable fixtures/test factories bridge
    // when I come to it
    
    // EVENT FIXTURES
    // Add EKEvent to calendar
    EKEventStore *store = [[EKEventStore alloc] init];
    EKEvent *event1 = [EKEvent eventWithEventStore:store];
    EKEvent *event2 = [EKEvent eventWithEventStore:store];
    event1.startDate = [[NSDate alloc] init];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:1];
    [offsetComponents setMinute:30];
    event1.endDate = [gregorian dateByAddingComponents:offsetComponents
                                                toDate:event1.startDate options:0];
    // make event 2 start 1:30 after event 1
    event2.startDate = [gregorian dateByAddingComponents:offsetComponents toDate:event1.endDate options:0];
    event2.endDate = [gregorian dateByAddingComponents:offsetComponents toDate:event2.startDate options:0];
    self.events = @[event1, event2];
    
    // TASK FIXTURES
    PKTTask *task1 = [[PKTTask alloc] initFromDictionary:@{@"title":@"Test task 1", @"length":@15}];
    PKTTask *task2 = [[PKTTask alloc] initFromDictionary:@{@"title":@"2nd test task", @"length":@30}];
    self.tasks = @[task1, task2];
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSchedulerOpenIntervals
{
    PKTInterval *testInterval = [[self.scheduler openTimeIntervalsBetweenEventsInArray:self.events] objectAtIndex:0];
    
    PKTInterval *correctInterval = [[PKTInterval alloc] init];
    correctInterval.interval = 60*60*1.5;
    correctInterval.startTime = [[self.events objectAtIndex:0] endDate];
    
    XCTAssertTrue([testInterval.startTime compare:correctInterval.startTime] == NSOrderedSame, @"Got different interval startTime than expected startTime");
    XCTAssertEqual(testInterval.interval, correctInterval.interval, @"Got different interval than expected duration");
}
- (void)testSchedulerTaskPacking
{
    NSArray *scheduledTasks = [self.scheduler packTasks:self.tasks intoIntervals:[self.scheduler openTimeIntervalsBetweenEventsInArray:self.events]];
    XCTAssertNotNil(scheduledTasks, @"Return value of packTasks was nil");
    NSUInteger count = [scheduledTasks count];
    XCTAssert(count != 0, @"scheduledTasks was empty");
}

@end
