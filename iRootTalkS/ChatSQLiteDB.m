//
//  ChatSQLiteDB.m
//  iRootTalkS
//
//  Created by 임재민 on 2019/12/10.
//  Copyright © 2019 임재민. All rights reserved.
//

#import "ChatSQLiteDB.h"

//#import "CppNetworkModule.hpp"

@implementation ChatSQLiteDB

@synthesize dataPath;
@synthesize conn;
@synthesize pDataArray;


-(void)createDBTable
{
    NSString *docdir;
    NSArray *path;
    
    pDataArray = [[NSMutableArray alloc] init ];
    
    path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docdir = path[0];
    
    dataPath = [[NSString alloc] initWithString:[docdir stringByAppendingPathComponent:@"chatdata.db"]];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    char *er;
    
    if([fm fileExistsAtPath:dataPath]==NO)
    {
        const char *dbPath = [dataPath UTF8String];
        
        if(sqlite3_open(dbPath, &conn)==SQLITE_OK)
        {
          //  const char *sqlQuery = "drop table chatdata";
            const char *sqlQuery = "create table if not exists chatdata (id integer primary key autoincrement, chattime text, chattext text, cellnum integer )";
            
            if(sqlite3_exec(conn, sqlQuery, NULL, NULL, &er)!=SQLITE_OK)
            {
                NSLog(@"Execution failed");
            }
            
            sqlite3_close(conn);
        }
    }
    else
    {
        NSLog(@"Exe");
    }
    
  //  [self selectDB];
}

-(void)insertDB:(NSString *)chattime chat:(NSString *)chattext cell:(int)cellnumber
{
    sqlite3_stmt *stmt;
    const char *dbPath = [dataPath UTF8String];
    
    if(sqlite3_open(dbPath, &conn)==SQLITE_OK)
    {
        NSString *insert = [NSString stringWithFormat:@"insert into chatdata (chattime, chattext, cellnum) values (\"%@\",\"%@\", %d )", chattime, chattext, cellnumber];
        
        const char *insert_sql = [insert UTF8String];
        
        if(sqlite3_prepare(conn, insert_sql, -1, &stmt, NULL)==SQLITE_OK)
        {
            if(sqlite3_step(stmt)==SQLITE_DONE)
            {
                /*
                 _txtName.text = @"";
                 _txtPhone.text = @"";
                 */
            }
            else
            {
                NSLog(@"%d", sqlite3_prepare(conn, insert_sql, -1, &stmt, NULL));
            }
            
            sqlite3_finalize(stmt);
            sqlite3_close(conn);
        }
    }
}

-(void)selectDB
{
    sqlite3 *db;

    const char *dbfile = [dataPath UTF8String];
    
    [pDataArray removeAllObjects]; // !!
    
    if(sqlite3_open(dbfile, &db)==SQLITE_OK)
    {
        const char *sql = [[NSString stringWithFormat:@"select id, chattime, chattext, cellnum from chatdata"] UTF8String ];
        
        sqlite3_stmt *stmt;
        
        if(sqlite3_prepare(db, sql, -1, &stmt, NULL)==SQLITE_OK)
        {
            while(sqlite3_step(stmt)==SQLITE_ROW)
            {
                /*
                NSNumber *id = @(sqlite3_column_int(stmt,0));
                
                NSLog(@"ID: %@", id);
                */
                int ide = sqlite3_column_int(stmt,0);
                
            //    NSLog(@"ID: %d", ide );
                
                NSString *chattime = [NSString stringWithUTF8String:sqlite3_column_text(stmt,1)];
                
                NSString *chattext = [NSString stringWithUTF8String:sqlite3_column_text(stmt,2)];
                
                int cellnumber = sqlite3_column_int(stmt,3);
                
             //   NSLog(@"Select DB cellnumber %d", cellnumber);
                
                [pDataArray addObject:[ChatCellData initWithName:nil time:chattime chat:chattext cell:cellnumber]];
            }
            sqlite3_finalize(stmt);
        }
        sqlite3_close(db);
    }
     //   if([result count]==0) return nil;
}

-(void)deleteDB
{
    
}

+(instancetype)sharedInstance
{
    static ChatSQLiteDB *shared = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shared = [[ChatSQLiteDB alloc] init];
    });
    
    return shared;
}

-(void)dropDBTable
{
    NSString *docdir;
    NSArray *path;
    
    pDataArray = [[NSMutableArray alloc] init ];
    
    path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docdir = path[0];
    
    dataPath = [[NSString alloc] initWithString:[docdir stringByAppendingPathComponent:@"chatdata.db"]];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    char *er;
    
   // if([fm fileExistsAtPath:dataPath]==NO)
   // {
        const char *dbPath = [dataPath UTF8String];
        
        if(sqlite3_open(dbPath, &conn)==SQLITE_OK)
        {
            const char *sqlQuery = "drop table chatdata";
            
            if(sqlite3_exec(conn, sqlQuery, NULL, NULL, &er)!=SQLITE_OK)
            {
                NSLog(@"Execution failed");
            }
            
            sqlite3_close(conn);
        }
  //  }
  //  else
//    {
    //    NSLog(@"Exe");
  //  }
}




@end
