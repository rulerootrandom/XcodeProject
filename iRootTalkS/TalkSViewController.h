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

NS_ASSUME_NONNULL_BEGIN

@interface TalkSViewController : ViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *pChatListView;

@end

NS_ASSUME_NONNULL_END
