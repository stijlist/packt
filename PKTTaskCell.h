//
//  PKTTaskCell.h
//  Packt
//
//  Created by Gerald Patterson on 2/28/14.
//  Copyright (c) 2014 Bert Muthalaly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKTTaskCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UITextField *title;
@property (weak, nonatomic) IBOutlet UITextField *timeInterval;

@end
