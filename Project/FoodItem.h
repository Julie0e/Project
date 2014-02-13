//
//  FoodItem.h
//  Project
//
//  Created by 주리 on 2014. 2. 3..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FoodItem : NSObject

@property (strong, nonatomic)NSString *name;
@property (strong, nonatomic)NSString *image;
//@property (nonatomic) int startDate;
@property (strong, nonatomic)NSDate *startDate;
@property (strong, nonatomic)NSDate *endDate;
@property (nonatomic) int lifeTime;
@property (nonatomic) int position;
@property (nonatomic) int rowid;
//+(id)product:(NSString *)name date:(NSString *)date;

@end
