//
//  FmdbEngine.m
//  FmdbTest
//
//  Created by hky on 16/3/17.
//  Copyright © 2016年 hky. All rights reserved.
//

#import "FmdbEngine.h"
#import <FMDB/FMDB.h>
#import "StudentModel.h"

static FMDatabaseQueue *_dbQueue;


@implementation FmdbEngine

+(instancetype)shareInstance
{
    static FmdbEngine *_engine;
    static dispatch_once_t onceTocken;
    dispatch_once(&onceTocken, ^{
        _engine = [[FmdbEngine alloc]init];
        _dbQueue = [[FMDatabaseQueue alloc]initWithPath:[_engine getDBPath:@"student"]];
        [_dbQueue inDatabase:^(FMDatabase *db) {
            if ([db open]) {
                NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (name text,number int)",@"student"];
                if ([db executeUpdate:sql]) {
                    NSLog(@"success!!!");
                }
                else
                {
                    NSLog(@"failure!!!!!");
                }
            }
        }];
    });
    return _engine;
}

- (void)startEngine
{
    NSInteger count = 100000;
     NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:count];
    for (NSInteger i = 0; i < count; i ++) {
        StudentModel *model = [[StudentModel alloc] init];
        model.number = i + 10000;
        model.name = [NSString stringWithFormat:@"lily%@",@(i)];
        [array addObject:model];
    }
    [[FmdbEngine shareInstance] insertDBWithoutIntransaction:array];
    [[FmdbEngine shareInstance] insertDBWithIntransaction:array];
}

- (void)insertDBWithoutIntransaction:(NSMutableArray*)array
{
  [_dbQueue inDatabase:^(FMDatabase *db) {
      [db setShouldCacheStatements:YES];
      NSTimeInterval start = [[NSDate date]timeIntervalSince1970];
      for (StudentModel *model in array) {
          NSString *sql = [NSString stringWithFormat:@"insert into student (name,number) values (?,?)"];
          [db executeUpdate:sql,model.name,[NSNumber numberWithInteger:model.number]];
      }
      NSTimeInterval end = [[NSDate date]timeIntervalSince1970];
      NSLog(@"----- insertDBWithoutIntransaction :%.6f",end-start);
  }];
}

-(void)insertDBWithIntransaction:(NSMutableArray *)array
{
    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db setShouldCacheStatements:YES];
        BOOL isRoolback = NO;
        NSTimeInterval start = [[NSDate date]timeIntervalSince1970];
        @try {
            [db beginTransaction];
            for (StudentModel *model in array) {
                NSString *sql = [NSString stringWithFormat:@"insert into student (name,number) values (?,?)"];
                [db executeUpdate:sql,model.name,[NSNumber numberWithInteger:model.number]];
            }
        }
        @catch (NSException *exception) {
            isRoolback = YES;
            [db rollback];
        }
        @finally {
            if (!isRoolback) {
                [db commit];
                NSTimeInterval end = [[NSDate date]timeIntervalSince1970];
                NSLog(@"----- insertDBWithIntransaction time :%.6f",end-start);
            }
            
            [db close];
        }
    }];
}

-(NSString *)getDBPath:(NSString *)tablename
{
    NSString *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *fileName = [NSString stringWithFormat:@"%@.db",tablename];
    
    NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
    NSLog( @"--- path :%@",dirPath);
    return filePath;
}


@end
