//
//  Food.h
//  Project
//
//  Created by 주리 on 2014. 2. 3..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodItem.h"


@interface Food : NSObject

@property NSMutableArray *items;

- (id)init;
+ (id)sharedFood;
- (void)resolveData;
- (NSInteger)addFoodWithName:(NSString *)name date:(NSString *)date ;
- (NSInteger)getNumberOfFoods;
- (NSString *)getNameOfFoodAtId:(NSInteger)rowId;
- (void)removeFood:(FoodItem *)item;

@end