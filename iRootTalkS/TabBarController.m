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
    
 
    /*
      // UI 를 업데이트 하기 위한 Background 작업을 하기 위한 코드 !!  // Background modes 를 설정해 주어야 한다..
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
                 NSLog(@"I am refreshing!!");
                 [self.pTalkSViewController refreshChatTableView];
                 [NSThread sleepForTimeInterval:1];
             }
             
             [application endBackgroundTask:background_task];
             
             background_task = UIBackgroundTaskInvalid;
         });
     }
     else
     {
         NSLog(@"Multitasking Not Supported");
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
