//
//  WebViewController.m
//  iRootTalkS
//
//  Created by 임재민 on 2019/12/09.
//  Copyright © 2019 임재민. All rights reserved.
//

#import "WebViewController.h"

#import "ViewController.h"

//#import "CppNetworkModule.hpp"

@interface WebViewController ()

@end

@implementation WebViewController

@synthesize pUserID;
@synthesize pLoginWeb;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 //   self.title = @"Log In";
    
    NSString *strURL = @"http://rootjm.com/php/roottalk/login.html";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strURL]];
    
    [self.pLoginWeb loadRequest:request];
    
    [self.pLoginWeb setDelegate:self];

}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    WebViewController *model = [[WebViewController alloc] init];
    
    self.jsContext[@"JSBridge"] = model;
    
    model.jsContext = self.jsContext;
    model.pLoginWeb = self.pLoginWeb;
    
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue)
    {
        NSLog(@"Exception: %@", exceptionValue);
    };
}

-(void)setUserID:(NSString *)pID
{
    self.pUserID = pID;
        
    NSLog(@"User ID: %@", self.pUserID );
    
    [ChatNetworkManager.sharedInstance loginConnectProcess:self.pUserID];
}

/*
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
