//
//  UserListViewController.h
//  iRootTalkS
//
//  Created by 임재민 on 2019/12/09.
//  Copyright © 2019 임재민. All rights reserved.
//

#import "ViewController.h"

#import "UserTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserListViewController : ViewController < UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *pUserListArray;

@property (strong, nonatomic) IBOutlet UITableView *pUserTableView;

-(void)queryUserIDList;

@end

NS_ASSUME_NONNULL_END
