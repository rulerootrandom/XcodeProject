//
//  TalkSViewController.m
//  iRootTalkS
//
//  Created by 임재민 on 2019/12/09.
//  Copyright © 2019 임재민. All rights reserved.
//

#import "TalkSViewController.h"

@interface TalkSViewController ()

@end

@implementation TalkSViewController
{
 //   NSMutableArray *pChatDataArray;
}

@synthesize pChatListView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    pChatListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
   // pChatDataArray = [[NSMutableArray alloc] init];
    
  //  UIImage *img = [[UIImage imageNamed:@"chatFaceIcon.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:16];

    [ChatSQLiteDB.sharedInstance createDBTable];
    
    [ChatSQLiteDB.sharedInstance insertDB:@"2020.11.11" chat:@"Hello, SQLite!!" cell:1];
    
    [ChatSQLiteDB.sharedInstance insertDB:@"2020.11.12" chat:@"Hello, SQLite!!" cell:1];
    
    [ChatSQLiteDB.sharedInstance insertDB:@"2020.11.13" chat:@"Hello, SQLite!!" cell:1];
    /*
    [pChatDataArray addObject:[ChatCellData initWithName:img time:@"2020.11.11" chat:@"Hello World!!" cell:0]];

    [pChatDataArray addObject:[ChatCellData initWithName:img time:@"2020.11.12" chat:@"Hello World!!" cell:1]];

    [pChatDataArray addObject:[ChatCellData initWithName:img time:@"2020.11.13" chat:@"Hello World!!" cell:0]];
    */
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
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger result = 0;
    
    if(section == 0)
    {
      //  result = [self->pChatDataArray count];
        result = [ChatSQLiteDB.sharedInstance.pDataArray count];
    }
    else
    {
        result = 0;
    }
    
    return result;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 반드시 식별자를 셀에 부여해야 에러가 않난다..
    static NSString *kReuseIdentifier;
    
 //   int cellNum = [[self->pChatDataArray objectAtIndex:indexPath.row] iCellNumber];
   
    int cellNum = [[ChatSQLiteDB.sharedInstance.pDataArray objectAtIndex:indexPath.row] iCellNumber];
    
    switch(cellNum)
    {
        case 0:
        {
            kReuseIdentifier= @"Left ChatList Item";
            LeftTableViewCell *pLeftCell = nil;
            
            if(indexPath.section == 0)
            {
                pLeftCell = (LeftTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
                
                /*
                pLeftCell.pUserImg.image = [[self->pChatDataArray objectAtIndex:indexPath.row] pUser];
                pLeftCell.pTime.text = [[self->pChatDataArray objectAtIndex:indexPath.row] pTime];
                pLeftCell.pChat.text = [[self->pChatDataArray objectAtIndex:indexPath.row] pChat];
                */
                
                pLeftCell.pUserImg.image = [[ChatSQLiteDB.sharedInstance.pDataArray objectAtIndex:indexPath.row] pUser];
                
                pLeftCell.pTime.text = [[ChatSQLiteDB.sharedInstance.pDataArray objectAtIndex:indexPath.row] pTime];
                
                pLeftCell.pChat.text = [[ChatSQLiteDB.sharedInstance.pDataArray objectAtIndex:indexPath.row] pChat];
                
                pLeftCell.pChat.editable = NO;
            }
            
            return pLeftCell;
        }
        break;
            
        case 1:
        {
            kReuseIdentifier= @"Right ChatList Item";
            RightTableViewCell *pRightCell = nil;
            
            if(indexPath.section == 0)
            {
                pRightCell = (RightTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
            }
            
            return pRightCell;
        }
        break;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    /*
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self->pChatDataArray removeObjectAtIndex:indexPath.row];
            
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

    }
    */
}

- (IBAction)AddItem:(id)sender
{
  //  UIImage *img = [[UIImage imageNamed:@"ChatFaceIcon.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:16];
    
   // [self->pChatDataArray addObject:[ChatCellData initWithName:img time:@"2020.11.14" chat:@"Add Hello World!!" cell:0]];
    
    [ChatSQLiteDB.sharedInstance insertDB:@"2020.11.22" chat:@"Add Hello, SQLite!!" cell:0];
    
    [ChatSQLiteDB.sharedInstance selectDB];
    
    [pChatListView reloadData];
}

@end
