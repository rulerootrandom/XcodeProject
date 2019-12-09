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
      
      self.pWebViewController = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
      NSLog(@"pWeb: %@", self.pWebViewController);
      
      self.pTalkSViewController = [storyboard instantiateViewControllerWithIdentifier:@"TalkSViewController"];
      NSLog(@"pTalk: %@", self.pTalkSViewController);
      
      self.pUserListViewController = [storyboard instantiateViewControllerWithIdentifier:@"UserListViewController"];
      NSLog(@"pUser: %@", self.pUserListViewController);
    
      self.pWebViewController.title = @"Log In";
      self.pTalkSViewController.title = @"TalkS";
      self.pUserListViewController.title = @"User List";
      
      self.viewControllers = @[self.pWebViewController, self.pTalkSViewController, self.pUserListViewController];
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
