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

NSString *kCellID = @"cellID";                          // UICollectionViewCell storyboard id

@interface PKTViewController ()

@property NSArray *events;
@property PKTEventManager *eventManager;

@end

@implementation PKTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.eventManager = [[PKTEventManager alloc] init];
    self.events = [self.eventManager eventsForCurrentDay];
	// Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return [self.events count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    // we're going to use a custom UICollectionViewCell, which will hold an image and its label
    PKTTaskCell *cell = [cv dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    
    // make the cell's title the actual NSIndexPath value
    cell.title.text = [NSString stringWithFormat:@"Item %ld", (long)indexPath.row];
    
    cell.timeInterval.text = @"30";
    
    return cell;
}

// the user tapped a collection item, load and set the image on the detail view controller
//
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"Tapped the task");
}

- (IBAction)createTaskButtonTouched:(id)sender {
    NSLog(@"Add new task pressed.");
    //Stub
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
