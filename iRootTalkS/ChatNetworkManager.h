//
//  ChatNetworkManager.h
//  iRootTalkS
//
//  Created by 임재민 on 2019/12/27.
//  Copyright © 2019 임재민. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatNetworkManager : NSObject

@property (strong, nonatomic) NSString *pUserID;

+(instancetype)sharedInstance;

-(void)loginConnectProcess:(NSString *)userID;


@end

NS_ASSUME_NONNULL_END
