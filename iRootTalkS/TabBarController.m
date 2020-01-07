//
//  TabBarController.m
//  iRootTalkS
//
//  Created by 임재민 on 2019/12/09.
//  Copyright © 2019 임재민. All rights reserved.
//

#import "TabBarController.h"

#import "WebViewController.h"
#import "TalkSViewController.h"
#import "UserListViewController.h"

#import "ChatSQLiteDB.h"

@interface TabBarController ()

@end

@implementation TabBarController

@synthesize pWebViewController;
@synthesize pTalkSViewController;
@synthesize pUserListViewController;


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
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
      
      self.pTalkSViewController = [storyboard instantiateViewControllerWithIdentifier:@"TalkSViewController"];
    
      NSLog(@"pTalk: %@", self.pTalkSViewController);
    
      self.pWebViewController = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    
      NSLog(@"pWeb: %@", self.pWebViewController);
      //!!
    //  self.pTalkSViewController.pTabBarView = self.view;
      //!!
    //  self.pTalkSViewController.pWebViewController = self.pWebViewController;
    
      self.pUserListViewController = [storyboard instantiateViewControllerWithIdentifier:@"UserListViewController"];
      NSLog(@"pUser: %@", self.pUserListViewController);
    
   //   self.pWebViewController.title = @"Log In";
      self.pTalkSViewController.title = @"TalkS";
      self.pUserListViewController.title = @"User List";
      
    
      self.viewControllers = @[self.pTalkSViewController, self.pUserListViewController];
         
     // self.viewControllers = @[self.pWebViewController, self.pTalkSViewController, self.pUserListViewController];
    
      self.delegate = self;
    
      //self.pWebViewController.pUserID
    /*
     // Background 에서 계속 작업을 처리한다..
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
                 
                 NSLog(@"Process Communication!!");
                 
                 if([pMsg isEqualToString:@""]==NO)
                 {
                   
                     [ChatSQLiteDB.sharedInstance insertDB:@"2020.1.1" chat:pMsg cell:0];
                     
                     [self.pTalkSViewController updateTalkTable];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
