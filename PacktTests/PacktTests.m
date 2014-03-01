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

@interface PacktTests : XCTestCase
@property PKTEventManager *eventManager;
@property NSArray *events;
@end

@implementation PacktTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.eventManager = [[PKTEventManager alloc] init];
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
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    NSArray *intervals = [self.eventManager openTimeIntervalsBetweenEventsInArray:self.events];
    NSNumber *correctInterval = [NSNumber numberWithDouble:60*60*1.5];
    XCTAssertEqualObjects(intervals, @[correctInterval], "Got interval array %@ but expected array %@");
}

@end
