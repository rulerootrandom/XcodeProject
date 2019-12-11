//
//  ChatCellData.m
//  iRootTalkS
//
//  Created by 임재민 on 2019/12/10.
//  Copyright © 2019 임재민. All rights reserved.
//

#import "ChatCellData.h"

@implementation ChatCellData

@synthesize pUser;
@synthesize pTime;
@synthesize pChat;
@synthesize iCellNumber;

+(ChatCellData *) initWithName:(UIImage *)userImg time:(NSString *)timeValue chat:(NSString *)chatValue cell:(int)cellNumber;
{
    ChatCellData *result = [[ChatCellData alloc] init ];
    
    result.pUser = userImg;
    result.pTime = timeValue;
    result.pChat = chatValue;
    result.iCellNumber = cellNumber;
    
    return result;
}

@end
