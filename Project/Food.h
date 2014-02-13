//
//  Food.h
//  Project
//
//  Created by 주리 on 2014. 2. 3..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodItem.h"
#import "AppDelegate.h"


@interface Food : NSObject

@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) NSMutableArray *freezeData;
@property (strong, nonatomic) NSMutableArray *refData;

@property (strong, nonatomic) NSMutableArray *rottenItems;

@property (strong, nonatomic) NSMutableDictionary *storeData;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

- (id)init;
+ (id)sharedFood;
- (void)resolveData;
- (void)clouluData;
- (NSInteger)lifetimeForName:(NSString *)name;
- (NSURL *)imageURLForName:(NSString *)name;
- (int)startDateForName:(NSString *)name;
- (BOOL)addFoodWithName:(NSString *)name endDate:(NSString *)endDate position:(int)position lifeTime:(int)lifeTime ;
- (NSInteger)getNumberOfFoods;
- (NSString *)getNameOfFoodAtId:(NSInteger)rowId;
- (void)removeFood:(FoodItem *)item;

@end