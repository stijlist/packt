//
//  PKTViewController.m
//  Packt
//
//  Created by Bert Muthalaly on 2/28/14.
//  Copyright (c) 2014 Bert Muthalaly. All rights reserved.
//

#import "PKTViewController.h"
#import "PKTTaskCell.h"
#import "PKTTask.h"
#import "PKTTaskScheduler.h"

NSString *kCellID = @"cellID";                          // UICollectionViewCell storyboard id

@interface PKTViewController ()

@property NSArray *events;
@property NSMutableArray *tasks;
@property PKTTaskScheduler *scheduler;
@end

@implementation PKTViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView setAlwaysBounceVertical:YES];
    self.tasks = [[NSMutableArray alloc] init];
    self.scheduler = [[PKTTaskScheduler alloc] init];
    
    
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
    cell.timeInterval.text = [[NSNumber numberWithUnsignedInt:[taskAtIndex length]] stringValue];
    
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
