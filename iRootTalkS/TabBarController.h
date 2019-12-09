//
//  TabBarController.h
//  iRootTalkS
//
//  Created by 임재민 on 2019/12/09.
//  Copyright © 2019 임재민. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WebViewController;
@class TalkSViewController;
@class UserListViewController;

@interface TabBarController : UITabBarController

@property (strong, nonatomic) WebViewController *pWebViewController;
@property (strong, nonatomic) TalkSViewController *pTalkSViewController;
@property (strong, nonatomic) UserListViewController *pUserListViewController;


@end

NS_ASSUME_NONNULL_END
