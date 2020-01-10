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
    //T  self.pTalkSViewController.title = @"TalkS";
      self.pTalkSViewController.tabBarItem.image = [UIImage imageNamed:@"talk.png"];
    
      //self.pUserListViewController.title = @"User List";
    self.pUserListViewController.tabBarItem.image = [UIImage imageNamed:@"userlist.png"];
    
      self.viewControllers = @[self.pTalkSViewController, self.pUserListViewController];
         
     // self.viewControllers = @[self.pWebViewController, self.pTalkSViewController, self.pUserListViewController];
    
    //  self.delegate = self;
    
 
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
