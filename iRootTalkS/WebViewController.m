//
//  WebViewController.m
//  iRootTalkS
//
//  Created by 임재민 on 2019/12/09.
//  Copyright © 2019 임재민. All rights reserved.
//

#import "WebViewController.h"

#import "ViewController.h"


@interface WebViewController ()


@end

@implementation WebViewController


@synthesize pUserID;
@synthesize pLoginWeb;
//@synthesize bEnter;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 //   self.title = @"Log In";
    
    NSString *strURL = @"http://rootjm.com/php/roottalk/login.html";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strURL]];
    
    [self.pLoginWeb loadRequest:request];
    
    [self.pLoginWeb setDelegate:self];

    NSLog(@"viewDidLoad pUserID: %@", self.pUserID);
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    NSLog(@"BeforeFinished: %@", self.pUserID);
    
    WebViewController *model = [[WebViewController alloc] init];
    
    self.jsContext[@"JSBridge"] = model;
    
    model.jsContext = self.jsContext;
    model.pLoginWeb = self.pLoginWeb;
    
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue)
    {
        NSLog(@"Exception: %@", exceptionValue);
    };
    
    NSLog(@"webViewDidFinishLoad!!");
    NSLog(@"AfterFinished: %@", self.pUserID);
    
    
    // !!
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentRootPath = [documentPaths objectAtIndex:0];
    
    NSString *stringFilePath = [documentRootPath stringByAppendingFormat:@"/myloginid.plist"];
    
    NSDictionary *stringDic = [[NSDictionary alloc] initWithContentsOfFile:stringFilePath];
    
    if(stringDic)
    {
        NSString *loadedString = [stringDic objectForKey:@"loginid"];
        
        NSLog(@"Loaded String: %@", loadedString);
        
        [self.delegate didSelectWith:self userid:loadedString];
    }
    else
    {
        NSLog(@"Loading Failure");
    }
    // !!
    
    
    /*
    static int loadcount;
    
    loadcount++;
    
    NSLog(@"loadcount: %d", loadcount);
    NSLog(@"bEnter: %d", bEnter);
    
    if(loadcount == 2)
    {
      UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
      
      button.frame = CGRectMake(100,100,100,100);
      
      [button setTitle:@"Enter" forState:UIControlStateNormal];
      
      [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
      
      [self.view addSubview:button];
    }
     */
  }

-(void)setUserID:(NSString *)pID
{
    /*
    self.pUserID = pID;
    
    NSLog(@"pUserID: %@", self.pUserID );
    //여기서만 동작하고 이후로는 nil 값이 셋팅된다.. 왜 ??
    [self.delegate didSelectWith:self userid:self.pUserID];
    */
    NSDictionary *stringDic = [[NSDictionary alloc] initWithObjectsAndKeys: pID, @"loginid", nil];
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *documentRootPath = [documentPaths objectAtIndex:0];
    
    NSString *stringFilePath = [documentRootPath stringByAppendingFormat:@"/myloginid.plist"];
    
    BOOL isWritten = NO;
    
    isWritten = [stringDic writeToFile:stringFilePath atomically:YES];
    
   // UIAlertView *alert = nil;
    if(isWritten)
    {
        /*
        alert = [[UIAlertView alloc] initWithTitle:@"알림" message:@"정상적으로 저장되었습니다" delegate:nil cancelButtonTitle:@"확인" otherButtonTitles:nil];
         */
        NSLog(@"파일 저장에 성공했습니다.");
    }
    else
    {
       // alert = [[UIAlertView alloc] initWithTitle:@"알림" message:@"파일 저장에 실패하였습니다" delegate:nil cancelButtonTitle:@"확인" otherButtonTitles:nil];
        NSLog(@"파일 저장에 실패했습니다.");
    }
    
   // bEnter = YES;

}

-(void)buttonClick
{
    NSLog(@"buttonClick");
}

- (IBAction)SubmitBtn:(UIButton *)sender {
    
    /*
    NSLog(@"Submit: %@", self.pUserID );
    
    [self.delegate didSelectWith:self userid:self.pUserID];
    */
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentRootPath = [documentPaths objectAtIndex:0];
    
    NSString *stringFilePath = [documentRootPath stringByAppendingFormat:@"/myloginid.plist"];
    
    NSDictionary *stringDic = [[NSDictionary alloc] initWithContentsOfFile:stringFilePath];
    
    if(stringDic)
    {
        NSString *loadedString = [stringDic objectForKey:@"loginid"];
        
        NSLog(@"Loaded String: %@", loadedString);
    }
    else
    {
        NSLog(@"Loading Failure");
    }
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
