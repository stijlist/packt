//
//  PKTViewController.m
//  Packt
//
//  Created by Bert Muthalaly on 2/28/14.
//  Copyright (c) 2014 Bert Muthalaly. All rights reserved.
//

#import "PKTViewController.h"
#import "PKTTaskCell.h"
#import "PKTEventManager.h"
#import "PKTTask.h"
#import <EventKit/EventKit.h>

NSString *kCellID = @"cellID";                          // UICollectionViewCell storyboard id

@interface PKTViewController ()

@property NSArray *events;
@property PKTEventManager *eventManager;
@property NSMutableArray *tasks;

@end

@implementation PKTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView setAlwaysBounceVertical:YES];
    self.eventManager = [[PKTEventManager alloc] init];
    self.events = [self.eventManager eventsForCurrentDay];
    self.tasks = [[NSMutableArray alloc] init];
    
    PKTTask *task1 = [[PKTTask alloc] init];
    [task1 setTitle:@"Task 1"];
    PKTTask *task2 = [[PKTTask alloc] init];
    [task2 setTitle:@"Task 2"];
    PKTTask *task3 = [[PKTTask alloc] init];
    [task3 setTitle:@"Task 3"];
    
    [self.tasks addObject:task1];
    [self.tasks addObject:task2];
    [self.tasks addObject:task3];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return [self.tasks count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    PKTTaskCell *cell = [cv dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    PKTTask *taskAtIndex = [self.tasks objectAtIndex:indexPath.row];
    
    cell.title.text = [taskAtIndex title];
    cell.timeInterval.text = @"30";
    
    return cell;
}

- (IBAction)doneEditing:(id)sender {
    NSLog(@"Done editing");
}

- (IBAction)createNewTaskButtonTouched:(id)sender {
    NSLog(@"Creating new task");
    PKTTask *newTask = [[PKTTask alloc] init];
    [self.tasks insertObject:newTask atIndex:0];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
