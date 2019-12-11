//
//  ChatCellData.h
//  iRootTalkS
//
//  Created by 임재민 on 2019/12/10.
//  Copyright © 2019 임재민. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatCellData : NSObject

@property (strong, nonatomic) UIImage *pUser;
@property (strong, nonatomic) NSString *pTime;
@property (strong, nonatomic) NSString *pChat;
@property (nonatomic) int iCellNumber;

+(ChatCellData *) initWithName:(UIImage *)userImg time:(NSString *)timeValue chat:(NSString *)chatValue cell:(int)cellNumber;

@end

NS_ASSUME_NONNULL_END
