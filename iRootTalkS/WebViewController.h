//
//  WebViewController.h
//  iRootTalkS
//
//  Created by 임재민 on 2019/12/09.
//  Copyright © 2019 임재민. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
//#import <UIKit/UIKit.h>

//#import "TalkSViewController.h"

NS_ASSUME_NONNULL_BEGIN

//!!

@class WebViewController;

@protocol webviewDelegate <NSObject>

-(void)didSelectWith:(WebViewController *)controller userid:(NSString *)pUserId;

@end

//!!


@protocol JavaScriptExportDelegate <JSExport>

-(void)setUserID:(NSString *)pID;

@end

@interface WebViewController : ViewController <JavaScriptExportDelegate>

@property (strong, nonatomic) NSString *pUserID;

@property (strong, nonatomic) IBOutlet UIWebView *pLoginWeb;

@property (strong, nonatomic) JSContext *jsContext;

//!!
@property (nonatomic, weak) id<webviewDelegate> delegate;

//@property BOOL bEnter;


-(void)buttonClick;

- (IBAction)SubmitBtn:(UIButton *)sender;

-(void)SaveID:(NSString *)pID;

-(void)loadID;


//!!

@end

NS_ASSUME_NONNULL_END
