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

NS_ASSUME_NONNULL_BEGIN

@protocol JavaScriptExportDelegate <JSExport>

-(void)setUserID:(NSString *)pID;

@end

@interface WebViewController : ViewController <JavaScriptExportDelegate>

@property (strong, nonatomic) NSString *pUserID;

@property (strong, nonatomic) IBOutlet UIWebView *pLoginWeb;

@property (strong, nonatomic) JSContext *jsContext;


@end

NS_ASSUME_NONNULL_END
