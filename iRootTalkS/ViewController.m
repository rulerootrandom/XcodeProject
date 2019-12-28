//
//  ViewController.m
//  iRootTalkS
//
//  Created by 임재민 on 2019/12/09.
//  Copyright © 2019 임재민. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController

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


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
    if( ConnectToServer()==0 )
    {
            //-----------------------------------1
       SetUserName("test1"); //----------------------------------2
       SendUserIDToServer(); //-------------------------------------------3
       InitSocketSets(); //---------------------------------------------4
    }
    
    SetUserMessage( "Hello!!! Communication !!" );
    
     // Background 작업을 하기 위한 코드 !!  // Background modes 를 설정해 주어야 한다..
    UIApplication *application = [UIApplication sharedApplication];

    if([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)])
    {
        NSLog(@"MultiTasking Supported");
        __block UIBackgroundTaskIdentifier background_task;
        
        background_task = [application beginBackgroundTaskWithExpirationHandler:^ {
            
            [application endBackgroundTask: background_task];
            background_task = UIBackgroundTaskInvalid;
        }];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            // Background Task starts..
            NSLog(@"Running in the background\n");
            
            while(true)
            {
                ProcessCommunication();
                
                NSString *pMsg = [NSString stringWithUTF8String:GetServerUserMessage().c_str()];
                
                if([pMsg isEqualToString:@""]==NO)
                {
                    NSLog(@"ChatMsg: %@", pMsg);
                }
                
                [NSThread sleepForTimeInterval:1];
            }
            
            [application endBackgroundTask:background_task];
            
            background_task = UIBackgroundTaskInvalid;
        });
    }
    else
    {
        NSLog(@"Multitasking Not Supported");
        
        // !!
        CloseSocket();
    }
     */
}

@end
