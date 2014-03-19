//
//  PKTViewController.h
//  Packt
//
//  Created by Bert Muthalaly on 2/28/14.
//  Copyright (c) 2014 Bert Muthalaly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKTViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
// TODO: remove this from public API ASAP. currently PKTTaskCell depends on it.
// better: make this viewcontroller a delegate for PKTTaskCell
- (void)deleteItemsAtIndexPaths:(NSArray *)indexPaths;

@end
