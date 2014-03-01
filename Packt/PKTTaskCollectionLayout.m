//
//  PKTTaskCollectionLayout.m
//  Packt
//
//  Created by Gerald Patterson on 2/28/14.
//  Copyright (c) 2014 Bert Muthalaly. All rights reserved.
//

#import "PKTTaskCollectionLayout.h"

@implementation PKTTaskCollectionLayout
- (void)awakeFromNib
{
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
}

- (void)prepareLayout
{
    [super prepareLayout];
    CGSize contentSize = self.collectionView.contentSize;
    NSArray *items = [super layoutAttributesForElementsInRect:
                      CGRectMake(0.0f, 0.0f, contentSize.width, contentSize.height)];
}


@end
