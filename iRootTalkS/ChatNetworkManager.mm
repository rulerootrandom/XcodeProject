//
//  ChatNetworkManager.m
//  iRootTalkS
//
//  Created by 임재민 on 2019/12/27.
//  Copyright © 2019 임재민. All rights reserved.
//

#import "ChatNetworkManager.h"

#import "CppNetworkModule.hpp"

@implementation ChatNetworkManager

@synthesize pUserID;

+(instancetype)sharedInstance
{
    static ChatNetworkManager *shared = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        shared = [[ChatNetworkManager alloc] init];
        
    });
    
    return shared;
}

-(void)loginConnectProcess:(NSString *)userID
{
    self.pUserID = userID;
    
    NSLog(@"ViewController UserID: %@", userID );
    
  
    
    
    //NSThread *pThread = [[NSThread alloc] initWithTarget:self selector:@selector(ProcessThread:) object:nil];
   // ConnectToServer();
 //   if( ConnectToServer()== 0 ) //---1
 //   {
  //      SetUserName([self.pUserID UTF8String]); //---2
        
   //     SendUserIDToServer(); //---3
        
    //    InitSocketSets(); //---4
}

/*
void SetUserMessage( std::string msg ); // 서버로 보낼 메시지를 큐에 저장한다..
std::string GetUserMessage(void);  //서버로 보낼 메시지 큐에서 메시지를 꺼내온다..  // 요기까지 밥먹구 이따가하자!! =.=;;
void SetUserList( std::string userId );
std::string GetUserList(void);
void SetServerUserMessage(std::string sMsg); // const char *message)  //서버에서 받은 메시지를 큐에 저장한다..
std::string GetServerUserMessage(void);  // 서버에서 받은 메시지를 저장한 큐에서 메시지를 가져온다..
int ConnectToServer(void); //-----------------------------------1
void SetUserName(const char *pUserName); //----------------------------------2
int SendUserIDToServer(void); //-------------------------------------------3
void InitSocketSets(void); //---------------------------------------------4
int ProcessCommunication(void); //-----------------------------------------5
void CloseSocket(void); //---------------------------------------------6
int QueryUserListFromServer(void);
*/


@end
