//
//  CppNetworkModule.hpp
//  iRootTalkS
//
//  Created by 임재민 on 2019/12/26.
//  Copyright © 2019 임재민. All rights reserved.
//

#ifndef CppNetworkModule_hpp
#define CppNetworkModule_hpp

#include <iostream>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <arpa/inet.h>
#include <pthread.h>
#include <unistd.h>
#include <queue>

using namespace std;

#define MAXMSGSIZE 1024
#define MAXNAMESIZE 30
#define SERVERIP "121.164.124.160"
#define PORT 2693

enum Protocols
{
    PT_ENTER = 0,    // 대화방에 입장하기..
    PT_TALK,     // 이야기 하기..
    PT_EXIT,      // 대화방 나가기..
    PT_DISCONNECT,  // 강제로 접속 끊고 나가기..
    PT_LOGINED,     // 이미 접속하고 있다..
    PT_USERLIST
};


struct CommonMessage
{
    int  Protocol;           // 프로토콜 번호..
    char UserID[MAXNAMESIZE];// 유저 아이디..
    char Message[MAXMSGSIZE];// 메시지..
};

//int serverSocket = -1;
//struct sockaddr_in serverAddr;
//fd_set read_fds, tmp_fds;
//int fileDesc;
//char userName[MAXNAMESIZE];
//ssize_t readedLength;
//ssize_t ret;

/*
CommonMessage sendMsg, readMsg;

queue < std::string > UserMessageQueue;
queue < std::string > ServerMessageQueue;
queue < std::string > UserListQueue;

char totalMessage[MAXNAMESIZE + MAXMSGSIZE + 10];
*/

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
//*/

#endif /* CppNetworkModule_hpp */
