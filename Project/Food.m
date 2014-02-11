//
//  Food.m
//  Project
//
//  Created by 주리 on 2014. 2. 3..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "Food.h"
#import <sqlite3.h>
#import "FoodItem.h"
#import "RegListCellViewController.h"
#import "AFNetworking.h"

@implementation Food
{
    sqlite3 *Food;
    NSArray *_data;
   
}

static Food *_instance = nil;

- (id)init
{
    self = [super init];
    if (self) {
        self.items = [[NSMutableArray alloc]init];
        [self openDB];
    }
    return self;
}

+ (id)sharedFood
{
    if (_instance == nil) {
        _instance = [[Food alloc] init];
    }
    return _instance;
}

- (BOOL)openDB
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbFilePath = [docPath stringByAppendingPathComponent:@"FOOD.sqlite"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL existFile = [fm fileExistsAtPath:dbFilePath];
    
    int ret = sqlite3_open([dbFilePath UTF8String], &Food);
    
    if (SQLITE_OK != ret) {
        return NO;
    }
    
    if (existFile == NO) {
        char *creatSQL = "CREATE TABLE IF NOT EXISTS FOOD (name TEXT, date TEXT)";
        char *errorMsg;
        ret = sqlite3_exec(Food, creatSQL, NULL, NULL, &errorMsg);
        if (SQLITE_OK != ret) {
            [fm removeItemAtPath:dbFilePath error:nil];
            NSLog(@"creating table with ret : %d", ret);
            return NO;
        }
    }
    return YES;
}

- (NSInteger)addFoodWithName:(NSString *)name date:(NSString *)date 
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO FOOD (name,date) VALUES ('%@','%@')", name,date];
    NSLog(@"sql : %@", sql);

    char *errMsg;
    int ret = sqlite3_exec(Food, [sql UTF8String], NULL, nil, &errMsg);
    
    if (SQLITE_OK != ret) {
        NSLog(@"Error on Insert New data : %s", errMsg);
    }
    NSInteger foodID = (NSInteger)sqlite3_last_insert_rowid(Food);
    [self resolveData];
    return foodID;
}



- (void)removeFood:(FoodItem *)item
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM FOOD WHERE rowid=%d",item.rowid];
    char *errorMsg;
    int ret = sqlite3_exec(Food, [sql UTF8String], NULL, NULL, &errorMsg);
    
    if (SQLITE_OK != ret) {
        NSLog(@"Error(%d) on deleting data : %s", ret, errorMsg);
        
    }
   
  
}

- (NSInteger)getNumberOfFoods
{
//    NSString *queryStr = @"SELECT count(rowid) FROM FOOD";
//    sqlite3_stmt *stmt;
//    int ret = sqlite3_prepare_v2(Food, [queryStr UTF8String], -1, &stmt, NULL);
//    
//    NSAssert2(SQLITE_OK == ret, @"Error(%d) on resolving data : %s", ret,sqlite3_errmsg(Food));
//    
//    NSInteger count;
//    while (SQLITE_ROW == sqlite3_step(stmt)) {
//        count = sqlite3_column_int(stmt, 0);
//    }
//    
//    sqlite3_finalize(stmt);
    return [self.items count];
}

- (NSString *)getNameOfFoodAtId:(NSInteger)rowId
{
    NSString *queryStr = [NSString stringWithFormat:@"SELECT rowid, title FROM FOOD where rowid=%d", (int)rowId];
    sqlite3_stmt *stmt;
    int ret = sqlite3_prepare_v2(Food, [queryStr UTF8String], -1, &stmt, NULL);
    
    NSAssert2(SQLITE_OK == ret, @"Error(%d) on resolving data : %s", ret,sqlite3_errmsg(Food));
    NSString *titleString;
    while (SQLITE_ROW == sqlite3_step(stmt)) {
        char *title = (char *)sqlite3_column_text(stmt, 1);
        titleString = [NSString stringWithCString:title encoding:NSUTF8StringEncoding];
    }
    
    sqlite3_finalize(stmt);
    return titleString;
}

- (void)resolveData
{
    [self.items removeAllObjects];
    
    NSString *queryStr = @"SELECT rowid, title FROM FOOD";
    sqlite3_stmt *stmt;
    int ret = sqlite3_prepare(Food, [queryStr UTF8String], -1, &stmt, NULL);
    NSAssert2(SQLITE_OK==ret, @"Error(%d) on resolving data : %s", ret, sqlite3_errmsg(Food));
    
 //   NSLog(@"완료");
    while (SQLITE_ROW == sqlite3_step(stmt))
    {
//        int rowID = sqlite3_column_int(stmt, 0);
//        char *title = (char *)sqlite3_column_text(stmt, 1);
//        
//        FoodItem *one = [[FoodItem alloc]init];
//        one.rowid = rowID;
//        one.name = [NSString stringWithCString:title encoding:NSUTF8StringEncoding];
//        [self.items addObject:one];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *para = @{@"updateDay": @"2014-01-01T05:53:24.000Z"};
    [manager POST:@"http://gcrowd1.sunjung1130.cloulu.com/getitem" parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"성공");
      
        _data = [responseObject objectForKey:@"result"];

       
        for (int i =0 ; i<_data.count; i++) {
            NSDictionary *_foodData;
            _foodData =[_data objectAtIndex:i];
            NSString * name = [_foodData objectForKey:@"name"];
            NSString * image = [_foodData objectForKey:@"imageId"];
            NSInteger dDay = [[_foodData objectForKey:@"date"]integerValue];
            NSInteger lifeTime = [[_foodData objectForKey:@"lifetime"]integerValue];
            
            FoodItem *one = [[FoodItem alloc]init];
            one.name = name;
            one.image = image;
            one.date = [NSDate dateWithTimeIntervalSince1970:dDay];
            one.endDate = [NSDate dateWithTimeInterval:lifeTime sinceDate:one.endDate];
           // one.endDate = [NSDate dateWithTimeInterval:lifeTime sinceDate:one.date];
            NSLog(@"one.date : %@",one.date);
            NSLog(@"endDate : %@",one.endDate);
            [self.items addObject:one];
        //    NSLog(@"name : %@",name);
            
        
          //  NSLog(@"one : %@",one.date);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"foodInfoUpdate" object:nil];
        
     
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error : %@",error);
    }];
    
    sqlite3_finalize(stmt);
}


@end
