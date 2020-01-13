//
//  UserListViewController.m
//  iRootTalkS
//
//  Created by 임재민 on 2019/12/09.
//  Copyright © 2019 임재민. All rights reserved.
//

#import "UserListViewController.h"

#import "CppNetworkModule.hpp"

@interface UserListViewController ()

@end

@implementation UserListViewController

@synthesize pUserListArray;
@synthesize pUserTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pUserListArray = [[NSMutableArray alloc] init];
 
    [self queryUserIDList];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}
    
-(void)queryUserIDList
{
    QueryUserListFromServer();
    
    [NSThread sleepForTimeInterval:4];

    [self.pUserListArray removeAllObjects];
    
    for(int i=0; i<getUserListCount(); i++)
    {
        NSString *pUserID = [NSString stringWithUTF8String:GetUserList().c_str()];
                     
        if([pUserID isEqualToString:@""]==NO)
        {
         [self.pUserListArray addObject:pUserID];
        }
    }

    [self.pUserTableView reloadData];
                    
    [self.pUserTableView setNeedsDisplay];
}

- (IBAction)queryUserList:(id)sender
{
    [self queryUserIDList];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
 //   [tableView setContentOffset:CGPointMake(0.0, tableView.contentSize.height-tableView.rowHeight)];
    
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger result = 0;
    
    if(section == 0)
    {
    //    result = [ChatSQLiteDB.sharedInstance.pDataArray count];
        result = [self.pUserListArray count];
    }
    else
    {
        result = 0;
    }
    
    return result;
}

/*
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize dataSize = [self getBoxSize:[[ChatSQLiteDB.sharedInstance.pDataArray objectAtIndex:indexPath.row] pChat]];
    
    return dataSize.height + 30;
}
*/


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 반드시 식별자를 셀에 부여해야 에러가 않난다..
    static NSString *kReuseIdentifier;
    
  //  int cellNum = [self.pUserListArry objectAtIndex:indexPath.row] iCellNumber];
    
 //   CGSize windowSize = self.pChatTableView.frame.size;
    
    kReuseIdentifier= @"User List Item";
     
    UserTableViewCell *pUserIDCell = nil;

    if(indexPath.section == 0)
    {
       pUserIDCell = (UserTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];

       //  pLeftCell.pChat.text = [[ChatSQLiteDB.sharedInstance.pDataArray objectAtIndex:indexPath.row] pChat];
        pUserIDCell.pUserID.text = [self.pUserListArray objectAtIndex:indexPath.row] ;
    }

    return pUserIDCell;
    
}

/*
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self->pChatDataArray removeObjectAtIndex:indexPath.row];
            
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

    }
}
*/

@end
