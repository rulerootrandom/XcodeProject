//
//  ChatSQLiteDB.h
//  iRootTalkS
//
//  Created by 임재민 on 2019/12/10.
//  Copyright © 2019 임재민. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ChatCellData.h"
//#import "CppNetworkModule.hpp"

NS_ASSUME_NONNULL_BEGIN

@interface ChatSQLiteDB : NSObject

@property (strong, nonatomic) NSString *dataPath;
@property (nonatomic) sqlite3 *conn;
@property (strong, nonatomic) NSMutableArray *pDataArray;


+(instancetype)sharedInstance;

-(void)createDBTable;
-(void)insertDB:(NSString *)chattime chat:(NSString *)chattext cell:(int)cellnumber;
-(void)selectDB;
-(void)deleteDB;
-(void)dropDBTable;



@end

NS_ASSUME_NONNULL_END
