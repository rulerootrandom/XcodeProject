//
//  TalkSViewController.h
//  iRootTalkS
//
//  Created by 임재민 on 2019/12/09.
//  Copyright © 2019 임재민. All rights reserved.
//

#import "ViewController.h"

#import "ChatSQLiteDB.h"
#import "ChatCellData.h"
#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"

#import "WebViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TalkSViewController : ViewController < UITextViewDelegate, webviewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *pChatTableView;
@property (strong, nonatomic) IBOutlet UIView *pInputBackView;
@property (weak, nonatomic) IBOutlet UITextView *pTextView;
@property (strong, nonatomic) IBOutlet UIButton *pSendButton;
@property (strong, nonatomic) IBOutlet UIView *pMainView;

-(CGSize)getBoxSize:(NSString *)pString;

-(void)loginToServer:(NSString *)pUserID;

///*
-(BOOL)heavyOperation;
//-(void)updateUI:(NSDictionary *)param;
-(void)updateUI:(NSString *)pUserID;
-(void)alertFail;
// */

@end

NS_ASSUME_NONNULL_END
