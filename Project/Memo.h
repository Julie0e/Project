//
//  Memo.h
//  Project
//
//  Created by 주리 on 2014. 2. 6..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Memo : NSObject

@property NSMutableArray *memo;

- (id)init;
+ (id)sharedMemo;
- (void)resolveData;
- (NSInteger)addMemo:(NSString *)memo;


@end
