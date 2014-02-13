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
        self.freezeData =[[NSMutableArray alloc]init];
        self.refData = [[NSMutableArray alloc]init];
        self.storeData = [[NSMutableDictionary alloc]init];
        self.rottenItems = [[NSMutableArray alloc]init];
        self.dateFormatter = [[NSDateFormatter alloc]init];
        [self.dateFormatter setDateFormat:@"yyyy년 MM월 dd일"];
        [self.dateFormatter setLocale:[NSLocale currentLocale]];
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
        char *creatSQL = "CREATE TABLE IF NOT EXISTS FOOD (name TEXT, endDate TEXT , position INTEGER, lifeTime INTEGER)";
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

- (BOOL)addFoodWithName:(NSString *)name endDate:(NSString *)endDate position:(int)position lifeTime:(int)lifeTime ;
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO FOOD (name,endDate,position,lifeTime) VALUES ('%@','%@','%d','%d')", name,endDate,position,lifeTime];
    NSLog(@"sql : %@", sql);

    char *errMsg;
    int ret = sqlite3_exec(Food, [sql UTF8String], NULL, nil, &errMsg);
    
    if (SQLITE_OK != ret) {
        NSLog(@"Error on Insert New data : %s", errMsg);
    }
    return YES;
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

    NSString *queryStr = @"SELECT count(rowid) FROM FOOD";
    sqlite3_stmt *stmt;
    int ret = sqlite3_prepare_v2(Food, [queryStr UTF8String], -1, &stmt, NULL);
    
    NSAssert2(SQLITE_OK == ret, @"Error(%d) on resolving data : %s", ret,sqlite3_errmsg(Food));
    
    NSInteger count;
    while (SQLITE_ROW == sqlite3_step(stmt)) {
        count = sqlite3_column_int(stmt, 0);
    }
    
    sqlite3_finalize(stmt);

    return [self.items count];
}

- (NSString *)getNameOfFoodAtId:(NSInteger)rowId
{
    NSString *queryStr = [NSString stringWithFormat:@"SELECT rowid, name, endDate, position, lifeTime FROM FOOD where rowid=%d", (int)rowId];
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

- (void)resolveData {
    
    [self.refData removeAllObjects];
    [self.freezeData removeAllObjects];
    [self.items removeAllObjects];
    [self.rottenItems removeAllObjects];
    
    NSString *queryStr = @"SELECT rowid,name,endDate,position,lifeTime FROM FOOD";
    sqlite3_stmt *stmt;
    int ret = sqlite3_prepare(Food, [queryStr UTF8String], -1, &stmt, NULL);
    NSAssert2(SQLITE_OK==ret, @"Error(%d) on resolving data : %s", ret, sqlite3_errmsg(Food));
    
    FoodItem *one;
    
    while (SQLITE_ROW == sqlite3_step(stmt))
    {
        int rowID = sqlite3_column_int(stmt, 0);
        char *title = (char *)sqlite3_column_text(stmt, 1);
       // int startDate = sqlite3_column_int(stmt, 2);
        char *endDate = (char *)sqlite3_column_text(stmt, 2);
      //  NSDate *endDate = (__bridge NSDate *)(sqlite3_column_value(stmt, 2));
        int position = sqlite3_column_int(stmt, 3);
        int lifeTime = sqlite3_column_int(stmt, 4);
        
        NSString *string = [NSString stringWithCString:endDate encoding:NSUTF8StringEncoding];
        
        one = [[FoodItem alloc] init];
        one.rowid = rowID;
        one.name = [NSString stringWithCString:title encoding:NSUTF8StringEncoding];
        one.endDate = [self.dateFormatter dateFromString:string];
        one.lifeTime = lifeTime;
        one.position = position;
        
        if (one.position == 0) {
            [self.freezeData addObject:one];
        }
        else if (one.position == 1)
        {
            [self.refData addObject:one];
        }
        
        NSDate *currentDate = [NSDate date];
        NSTimeInterval timeInterval = [one.endDate timeIntervalSinceDate:currentDate];
        
        
//        NSLog(@"currentDate : %@", currentDate);
//        NSLog(@"endDate : %@", one.endDate);
//        NSLog(@"timeinterval : %f", timeInterval);
        
        if (timeInterval < 0) {
            [self.rottenItems addObject:one];
            NSLog(@"%@",self.rottenItems);
        }
        
        // 배열 여러개 ... (냉장/냉동/전체)
        [self.items addObject:one];
    }
    
    sqlite3_finalize(stmt);
}

- (void)clouluData
{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSDictionary *para = @{@"updateDay": @"2014-01-01T05:53:24.000Z"};
//    [manager POST:@"http://gcrowd1.sunjung1130.cloulu.com/getitem" parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"성공");
// json파싱
// _data

    NSURL *urlCurrent = [NSURL URLWithString:@"http://gcrowd1.sunjung1130.cloulu.com/getitem"];

    __autoreleasing NSError *error;
    __autoreleasing NSURLResponse *response;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlCurrent];
    [request setHTTPMethod:@"POST"];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
   
    NSDictionary *diccccccccc =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSArray *arr =[diccccccccc objectForKey:@"result"];
    for (NSDictionary *foodinfo in arr) {
        NSString *name =[foodinfo objectForKey:@"name"];
        [self.storeData setObject:foodinfo forKey:name];
    }
}

- (NSInteger)lifetimeForName:(NSString *)name
{
    NSDictionary *foodinfo = [self.storeData objectForKey:name];
    NSString *lifetimeString = [foodinfo objectForKey:@"lifetime"];
    NSInteger lifetime = [lifetimeString integerValue];
    
    return lifetime;
}

- (NSURL *)imageURLForName:(NSString *)name
{
    NSDictionary *foodinfo = [self.storeData objectForKey:name];
    NSString *imageURLString = [foodinfo objectForKey:@"imageId"];
    NSURL *imageURL = [NSURL URLWithString:imageURLString];
    
    return imageURL;
}

- (int)startDateForName:(NSString *)name
{
    NSDictionary *foodinfo = [self.storeData objectForKey:name];
    NSString *startString = [foodinfo objectForKey:@"date"];
    int startDate = [startString integerValue];

    return startDate;
}


@end

