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

@property NSMutableArray *tasks;
@property PKTTaskScheduler *scheduler;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *gestureRecognizer;
@property BOOL isCreatingTask;

@end

@implementation PKTViewController

- (NSInteger)collectionView:(UICollectionView *)asker numberOfItemsInSection:(NSInteger)section
{
    return [self.tasks count]; // this is the Controller interpreting the Model for the View
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.collectionView setAlwaysBounceVertical:YES];
    self.tasks = [[NSMutableArray alloc] init];
    self.scheduler = [[PKTTaskScheduler alloc] init];
    self.isCreatingTask = NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    PKTTaskCell *cell = [cv dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    PKTTask *taskAtIndex = [self.tasks objectAtIndex:indexPath.row];
    
    cell.title.text = taskAtIndex.title;
    cell.timeInterval.text = [[NSNumber numberWithUnsignedInt:taskAtIndex.length] stringValue];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(320, 50);
}

- (IBAction)doneEditing:(id)sender {
    NSLog(@"Done editing");
    self.isCreatingTask = NO;
    UITextField *senderTextField = (UITextField *) sender;
    PKTTaskCell *taskCell = (PKTTaskCell *)[[senderTextField superview] superview];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:taskCell];
    PKTTask *task = (PKTTask*)[self.tasks objectAtIndex:indexPath.row];
    
    task.title = [taskCell title].text;
    task.length = [[taskCell timeInterval].text integerValue];
    self.navigationItem.rightBarButtonItem.enabled = YES;

    
    if([[taskCell title].text length] == 0) {
        NSArray *indexPaths = [NSArray arrayWithObject:[self.collectionView indexPathForCell:taskCell]];
        [self.tasks removeObjectAtIndex:0];
        [self.collectionView deleteItemsAtIndexPaths:indexPaths];
    }
}

- (IBAction)createNewTaskButtonTouched:(id)sender {
    if(self.isCreatingTask == NO){
        self.isCreatingTask = YES;
    NSLog(@"Creating new task");
    PKTTask *newTask = [[PKTTask alloc] init];
    [self.tasks insertObject:newTask atIndex:0];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.collectionView insertItemsAtIndexPaths:indexPaths];
    //This is probably not the right place for this.
    [[(PKTTaskCell *)[self.collectionView cellForItemAtIndexPath:indexPath] title] becomeFirstResponder];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

- (IBAction)pannedOnTaskList:(id)sender {
    UIPanGestureRecognizer *panRecognizer = (UIPanGestureRecognizer *) sender;
    CGPoint velocity = [panRecognizer velocityInView:self.collectionView];
    //NSLog(@"%.20f", velocity.y);
    if(velocity.y > 400) {
        NSLog(@"Down Pan detected.");
        [self createNewTaskButtonTouched:self];
    } else if (velocity.y < -400) {
        NSLog(@"Up pan detected.");
    }
}

- (IBAction)swipedOnTask:(id)sender {
    //STUB: Do something when the task gets swiped
    NSLog(@"Swiped on the task");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
