//
//  LeftTableViewCell.h
//  iRootTalkS
//
//  Created by 임재민 on 2019/12/10.
//  Copyright © 2019 임재민. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeftTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *pUserImg;
@property (strong, nonatomic) IBOutlet UILabel *pTime;
@property (strong, nonatomic) IBOutlet UITextView *pChat;

@end

NS_ASSUME_NONNULL_END
