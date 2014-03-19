//
//  PKTTaskCell.m
//  Packt
//
//  Created by Gerald Patterson on 2/28/14.
//  Copyright (c) 2014 Bert Muthalaly. All rights reserved.
//

#import "PKTTaskCell.h"
#import "PKTViewController.h"
@implementation PKTTaskCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// TODO: this code DEFINITELY shouldn't be in here
// ideas:
// - make a delegate protocol for PKTTask cell
// - implement more iOS-style 2 step swipe to reveal delete button / press delete button flow
- (IBAction)deleteButtonPressed:(id)sender {
    UICollectionView *sup = (UICollectionView *)[self superview];
    NSArray *indexPaths = @[[sup indexPathForCell:self]];
    // ugh this cast is the literal worst
    [(PKTViewController *)[sup dataSource] deleteItemsAtIndexPaths: indexPaths];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
