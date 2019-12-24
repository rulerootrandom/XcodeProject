//
//  TalkSViewController.m
//  iRootTalkS
//
//  Created by 임재민 on 2019/12/09.
//  Copyright © 2019 임재민. All rights reserved.
//

#import "TalkSViewController.h"

#define WIDTH_SPACE       100.f
#define RIGHT_WIDTH_SPACE  58.0f


@interface TalkSViewController ()

@end

@implementation TalkSViewController
{

}

@synthesize pChatListView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    pChatListView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
  //  UIImage *img = [[UIImage imageNamed:@"chatFaceIcon.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:16];

    [ChatSQLiteDB.sharedInstance createDBTable];
    
   // /*
    [ChatSQLiteDB.sharedInstance insertDB:@"2020.11.11" chat:@"Hello, Every SQLite!!" cell:0];
    
    [ChatSQLiteDB.sharedInstance insertDB:@"2020.11.12" chat:@"Hello, Good Night SQLite!!" cell:0];
    
    [ChatSQLiteDB.sharedInstance insertDB:@"2020.11.13" chat:@"질문 내용은 이렇습니다! 1. 언제 처음 VR을 접하게 되셨나요?유니티를 공부하다가 유니티에서도 VR 프로그램을 할 수있다는 것을 알게 되었습니다.. 그래서 휴대폰에서 VR 을 체험 할 수 있는 Gear VR Occulus 을 구입해서 그 기기로 가상 현실울 처음 접하게 되었습니다..2. VR을 접해 보셨다면 AR도 접해 보셨을텐데, VR을 선택한 이유가 있으신가요? AR 도 역시 유니티에서 SDK 를 설치하고 AR 예제를 돌려 볼 수 있는데 제가 공부를 해보니 내가 예상했을 AR 이 쉬울 줄 알았는데 VR 개발이 더 쉽더라구요.. VR 우선 3D 로 게임이든 앱이든 만들어 놓기만 하면 거기에 들어가는 카메라만 여러가지 VR SDK 에서 제공하는 카메라로 바꾸기만 하면 바로 가상 현실 체험을 해볼 수 있습니다.. 차라리 AR 을 구현하는 것이 더 손이 많이 가고 더 기술력이 많이 필요한 것 같습니다.. 그래서 VR 개발 쪽으로 선택을 했습니다.." cell:0];
    //*/
 
    [ChatSQLiteDB.sharedInstance selectDB];
    
    [pChatListView reloadData];
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
    CGSize dataSize = [self getBoxSize:[[ChatSQLiteDB.sharedInstance.pDataArray objectAtIndex:indexPath.row] pChat]];
    
    return dataSize.height + 30;
}

-(CGSize)getBoxSize:(NSString *)string
{
    CGSize maxSize = CGSizeMake(200.0, 1000.0);
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, [UIColor blackColor], NSForegroundColorAttributeName, nil];
    
    CGRect text_size = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:nil];
    
    return CGSizeMake(text_size.size.width+10, text_size.size.height);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 반드시 식별자를 셀에 부여해야 에러가 않난다..
    static NSString *kReuseIdentifier;
    
    int cellNum = [[ChatSQLiteDB.sharedInstance.pDataArray objectAtIndex:indexPath.row] iCellNumber];
    
    // !!
    CGSize windowSize = self.pChatListView.frame.size;
    // !!
    
    switch(cellNum)
    {
        case 0:
        {
            kReuseIdentifier= @"Left ChatList Item";
            LeftTableViewCell *pLeftCell = nil;
            
            if(indexPath.section == 0)
            {
                pLeftCell = (LeftTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
            
                CGSize dataSize = [self getBoxSize:[[ChatSQLiteDB.sharedInstance.pDataArray objectAtIndex:indexPath.row] pChat]];
                
                pLeftCell.pTime.frame = CGRectMake(0, 0, 100, 14 );
                
                pLeftCell.pTime.text = [[ChatSQLiteDB.sharedInstance.pDataArray objectAtIndex:indexPath.row] pTime];
                
                pLeftCell.pBack.frame = CGRectMake( 0, 14, dataSize.width, dataSize.height);
                              
                pLeftCell.pChat.frame = CGRectMake( 0, 14, dataSize.width, dataSize.height);
                
                pLeftCell.pChat.text = [[ChatSQLiteDB.sharedInstance.pDataArray objectAtIndex:indexPath.row] pChat];
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
                           
               CGSize dataSize = [self getBoxSize:[[ChatSQLiteDB.sharedInstance.pDataArray objectAtIndex:indexPath.row] pChat]];
               
               pRightCell.pTime.frame = CGRectMake(windowSize.width-100-10, 0, 100, 14 );
               
               pRightCell.pTime.text = [[ChatSQLiteDB.sharedInstance.pDataArray objectAtIndex:indexPath.row] pTime];
               
               pRightCell.pBack.frame = CGRectMake( windowSize.width-dataSize.width-10, 14, dataSize.width, dataSize.height);
                             
               pRightCell.pChat.frame = CGRectMake( windowSize.width-dataSize.width-10, 14, dataSize.width, dataSize.height);
               
               pRightCell.pChat.text = [[ChatSQLiteDB.sharedInstance.pDataArray objectAtIndex:indexPath.row] pChat];
                
                // 요기할 차례다.. 밥 먹고 이따가 하자.. !!!
            }
            
            return pRightCell;
        }
        break;
    }
    
    return nil;
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

- (IBAction)AddItem:(id)sender
{
  //  UIImage *img = [[UIImage imageNamed:@"ChatFaceIcon.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:16];
    
   // [self->pChatDataArray addObject:[ChatCellData initWithName:img time:@"2020.11.14" chat:@"Add Hello World!!" cell:0]];
    
    [ChatSQLiteDB.sharedInstance insertDB:@"2020.11.25" chat:@"질문 내용은 이렇습니다! 1. 언제 처음 VR을 접하게 되셨나요?유니티를 공부하다가 유니티에서도 VR 프로그램을 할 수있다는 것을 알게 되었습니다.. 그래서 휴대폰에서 VR 을 체험 할 수 있는 Gear VR Occulus 을 구입해서 그 기기로 가상 현실울 처음 접하게 되었습니다..2. VR을 접해 보셨다면 AR도 접해 보셨을텐데, VR을 선택한 이유가 있으신가요? AR 도 역시 유니티에서 SDK 를 설치하고 AR 예제를 돌려 볼 수 있는데 제가 공부를 해보니 내가 예상했을 AR 이 쉬울 줄 알았는데 VR 개발이 더 쉽더라구요.. VR 우선 3D 로 게임이든 앱이든 만들어 놓기만 하면 거기에 들어가는 카메라만 여러가지 VR SDK 에서 제공하는 카메라로 바꾸기만 하면 바로 가상 현실 체험을 해볼 수 있습니다.. 차라리 AR 을 구현하는 것이 더 손이 많이 가고 더 기술력이 많이 필요한 것 같습니다.. 그래서 VR 개발 쪽으로 선택을 했습니다.." cell:1];
    
    [ChatSQLiteDB.sharedInstance selectDB];
    
    [pChatListView reloadData];
}
- (IBAction)DropTable:(id)sender {
    
    /*
    [ChatSQLiteDB.sharedInstance dropDBTable];
    
    [ChatSQLiteDB.sharedInstance selectDB];
    
    [pChatListView reloadData];
    */
}

@end
