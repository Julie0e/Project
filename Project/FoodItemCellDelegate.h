//
//  FoodItemCellDelegate.h
//  Project
//
//  Created by 주리 on 2014. 2. 6..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FoodItemCell;
@protocol FoodItemCellDelegate <NSObject>
- (void) deleteFood:(FoodItemCell *)foodItemCell;
@end
