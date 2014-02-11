//
//  FoodItemCell.h
//  Project
//
//  Created by 주리 on 2014. 2. 5..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodItemCellDelegate.h"

@interface FoodItemCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet id<FoodItemCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;

@property (weak, nonatomic) IBOutlet UILabel *foodName;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

- (IBAction)foodDelete:(id)sender;

@end
