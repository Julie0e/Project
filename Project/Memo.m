//
//  Memo.m
//  Project
//
//  Created by 주리 on 2014. 2. 6..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "Memo.h"
#import <sqlite3.h>
#import "MemoItem.h"


@implementation Memo
{
    sqlite3 *Memo;
}

static Memo *_instance = nil;

- (id)init
{
    self = [super init];
    if (self) {
        self.memo = [[NSMutableArray alloc]init];
        [self openDB];
    }
    return self;
}

+ (id)sharedMemo
{
    if (_instance == nil) {
        _instance = [[Memo alloc] init];
    }
    return _instance;
}

- (BOOL)openDB
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbFilePath = [docPath stringByAppendingPathComponent:@"MEMO.sqlite"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL existFile = [fm fileExistsAtPath:dbFilePath];
    
    int ret = sqlite3_open([dbFilePath UTF8String], &Memo);
    
    if (SQLITE_OK != ret) {
        return NO;
    }
    
    if (existFile == NO) {
        char *creatSQL = "CREATE TABLE IF NOT EXISTS MEMO (TITLE TEXT)";
        char *errorMsg;
        ret = sqlite3_exec(Memo, creatSQL, NULL, NULL, &errorMsg);
        if (SQLITE_OK != ret) {
            [fm removeItemAtPath:dbFilePath error:nil];
            NSLog(@"creating table with ret : %d", ret);
            return NO;
        }
    }
    return YES;
}

- (NSInteger)addMemo:(NSString *)memo;
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO MEMO (TITLE) VALUES ('%@')", memo];
    NSLog(@"sql : %@", sql);
    
    char *errMsg;
    int ret = sqlite3_exec(Memo, [sql UTF8String], NULL, nil, &errMsg);
    
    if (SQLITE_OK != ret) {
        NSLog(@"Error on Insert New data : %s", errMsg);
    }
    NSInteger ID = (NSInteger)sqlite3_last_insert_rowid(Memo);
    [self resolveData];
    return ID;
}

- (void)resolveData
{
    [self.memo removeAllObjects];
    
    NSString *queryStr = @"SELECT rowid, title FROM MEMO";
    sqlite3_stmt *stmt;
    int ret = sqlite3_prepare(Memo, [queryStr UTF8String], -1, &stmt, NULL);
    NSAssert2(SQLITE_OK==ret, @"Error(%d) on resolving data : %s", ret, sqlite3_errmsg(Memo));
    
    //   NSLog(@"완료");
    while (SQLITE_ROW == sqlite3_step(stmt))
    {
       // int rowID = sqlite3_column_int(stmt, 0);
        char *title = (char *)sqlite3_column_text(stmt, 1);
        
        MemoItem *one = [[MemoItem alloc]init];
     
        one.memo = [NSString stringWithCString:title encoding:NSUTF8StringEncoding];
        [self.memo addObject:one];
    }
    
    sqlite3_finalize(stmt);
}


@end
