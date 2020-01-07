//
//  TalkSViewController.m
//  iRootTalkS
//
//  Created by 임재민 on 2019/12/09.
//  Copyright © 2019 임재민. All rights reserved.
//

#import "TalkSViewController.h"

#import "CppNetworkModule.hpp"


@interface TalkSViewController ()

@end

@implementation TalkSViewController

@synthesize pChatTableView;
@synthesize pTextView;
@synthesize pSendButton;
@synthesize pMainView;
@synthesize pInputBackView;
///
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ToTalkS"])
    {
        WebViewController *vc = [segue destinationViewController];
        vc.delegate = self;
        
        NSLog(@"prepareForSegue!!: userid: %@", vc.pUserID);
    }
}
//*/

//!!
-(void)didSelectWith:(WebViewController *)controller userid:(NSString *)pUserId
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"WebView Login ID: %@", pUserId);
    
    [self loginToServer:pUserId];
}

- (IBAction)SendButton:(id)sender {
    
    [pTextView resignFirstResponder];
    
    NSString *pMsg = pTextView.text;
    
    if([pMsg isEqualToString:@""]==NO)
    {
        SetUserMessage( [pMsg UTF8String] );
        
        [ChatSQLiteDB.sharedInstance insertDB:@"2020.1.1" chat:pMsg cell:1];
                            
        [ChatSQLiteDB.sharedInstance.pDataArray addObject:[ChatCellData initWithName:nil time:@"2020.1.1" chat:pMsg cell:1]];
        
        [self.pChatTableView reloadData];
        
        NSIndexPath *index = [NSIndexPath indexPathForRow:[self.pChatTableView numberOfRowsInSection:0]-1 inSection:0];
        
        [self.pChatTableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                
        [self.pChatTableView setNeedsDisplay];  //잘 동작한다..

        pTextView.text = @"";
    }
    //!!
}
//!!

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    pChatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
  //  UIImage *img = [[UIImage imageNamed:@"chatFaceIcon.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:16];
    [ChatSQLiteDB.sharedInstance createDBTable];
 
    [ChatSQLiteDB.sharedInstance selectDB];
    
    [self.pChatTableView reloadData];
    
    if([ChatSQLiteDB.sharedInstance.pDataArray count]>0)
    {
        NSIndexPath *index = [NSIndexPath indexPathForRow:[self.pChatTableView numberOfRowsInSection:0]-1 inSection:0];
                       
        [self.pChatTableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
            
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // !!
   // /*
    CGRect pMainFrame = pMainView.frame;
    
    CGRect pFrame = pInputBackView.frame;
       
    pFrame.origin.y = pMainFrame.size.height - 2 * pFrame.size.height;

    pInputBackView.frame = pFrame;
    // */
    // !!

  
}


-(BOOL)heavyOperation
{
   // while(1)
   // {
        NSLog(@"Heavy Operation!!!");
   // }
    
    return YES;
}

-(void)updateUI:(NSString *)pUserID
{
    if( ConnectToServer()==0 )  //-----------------------------------1
    {
       SetUserName([pUserID UTF8String]); //----------------------------------2
       SendUserIDToServer(); //-------------------------------------------3
       InitSocketSets(); //---------------------------------------------4
        
        while(true)
        {
            ProcessCommunication();
            
            NSString *pMsg = [NSString stringWithUTF8String:GetServerUserMessage().c_str()];
            
            NSLog(@"Process Communication!!");
            
            if([pMsg isEqualToString:@""]==NO)
            {
                [ChatSQLiteDB.sharedInstance insertDB:@"2020.1.1" chat:pMsg cell:0];
                
               // [ChatSQLiteDB.sharedInstance selectDB];
                [ChatSQLiteDB.sharedInstance.pDataArray addObject:[ChatCellData initWithName:nil time:@"2020.1.1" chat:pMsg cell:0]];

                [self.pChatTableView reloadData];
                 
              // if([ChatSQLiteDB.sharedInstance.pDataArray count]>0)
              // {
                    NSIndexPath *index = [NSIndexPath indexPathForRow:[self.pChatTableView numberOfRowsInSection:0]-1 inSection:0];
                    
                    [self.pChatTableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
             //  }
                [self.pChatTableView setNeedsDisplay];
            }
            
            [NSThread sleepForTimeInterval:1];
        }
    }
    
   // [self.pChatTableView setNeedsDisplay];
}

-(void)alertFail
{
    
}


-(void)keyboardWillShow:(NSNotification *)pNotification
{
    CGRect pMainFrame = pMainView.frame;
    
    CGRect pFrame = pInputBackView.frame;
        
    NSDictionary *userInfo = [pNotification userInfo];
    
    CGRect bound;
    
    [(NSValue *) [userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&bound];

    pFrame.origin.y = pMainFrame.size.height - (bound.size.height + pFrame.size.height + 36.0f);
    
    pInputBackView.frame = pFrame;
    
    NSLog(@"KeyboardWillShow");
}

-(void)keyboardWillHide:(NSNotification *)pNotification
{
    CGRect pMainFrame = pMainView.frame;
    
    CGRect pFrame = pInputBackView.frame;
       
    NSDictionary *userInfo = [pNotification userInfo];

    CGRect bound;

    [(NSValue *) [userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&bound];

    pFrame.origin.y = pMainFrame.size.height - 2 * pFrame.size.height;

    pInputBackView.frame = pFrame;
    
    NSLog(@"KeyboardWillHide");
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)loginToServer:(NSString *)pUserID
{
      /*
      // !! 주기적으로 화면 갱신을 하기 위해서
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
          
          BOOL res = [self heavyOperation];
          
          dispatch_async(dispatch_get_main_queue(), ^{
              
              if(res)
              {
                  [self updateUI:pUserID];
              }
              else
              {
                  [self alertFail];
              }
          });
      });
      // !!
      */
    
    
    ///*
     // Background 작업을 하기 위한 코드 !!  // Background modes 를 설정해 주어야 한다..
     UIApplication *application = [UIApplication sharedApplication];

     if([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)])
     {
         NSLog(@"MultiTasking Supported");
         __block UIBackgroundTaskIdentifier background_task;
         
         background_task = [application beginBackgroundTaskWithExpirationHandler:^ {
             
             [application endBackgroundTask: background_task];
             background_task = UIBackgroundTaskInvalid;
         }];
         
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             
             // Background Task starts..
             NSLog(@"Running in the background\n");
             
             if( ConnectToServer()==0 )
             {
                     //-----------------------------------1
                SetUserName([pUserID UTF8String]); //----------------------------------2
                SendUserIDToServer(); //-------------------------------------------3
                InitSocketSets(); //---------------------------------------------4
                 
             //   SetUserMessage( "Hello!!! Communication !!" );
             }
             
             while(true)
             {
                 ProcessCommunication();
                 
                 NSString *pMsg = [NSString stringWithUTF8String:GetServerUserMessage().c_str()];
                 
                 NSLog(@"Process Communication!!");
                 
                 if([pMsg isEqualToString:@""]==NO)
                 {
                     [ChatSQLiteDB.sharedInstance insertDB:@"2020.1.1" chat:pMsg cell:0];
                     
                    // [ChatSQLiteDB.sharedInstance selectDB];
                     [ChatSQLiteDB.sharedInstance.pDataArray addObject:[ChatCellData initWithName:nil time:@"2020.1.1" chat:pMsg cell:0]];

                     [self.pChatTableView reloadData];
                      
                   // if([ChatSQLiteDB.sharedInstance.pDataArray count]>0)
                   // {
                         NSIndexPath *index = [NSIndexPath indexPathForRow:[self.pChatTableView numberOfRowsInSection:0]-1 inSection:0];
                         
                         [self.pChatTableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                  //  }
                     [self.pChatTableView setNeedsDisplay];
                 }
                 
                 [NSThread sleepForTimeInterval:1];
             }
             
             [application endBackgroundTask:background_task];
             
             background_task = UIBackgroundTaskInvalid;
             
             CloseSocket();
         });
     }
     else
     {
         NSLog(@"Multitasking Not Supported");
         
         // !!
         CloseSocket();
     }
     //*/
    
    NSLog(@"You are Loginned %@", pUserID);
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

-(CGSize)getBoxSize:(NSString *)pString
{
    CGSize maxSize = CGSizeMake(200.0, 1000.0);
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, [UIColor blackColor], NSForegroundColorAttributeName, nil];
    
    CGRect text_size = [pString boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:nil];
    
    return CGSizeMake(text_size.size.width+10, text_size.size.height);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 반드시 식별자를 셀에 부여해야 에러가 않난다..
    static NSString *kReuseIdentifier;
    
    int cellNum = [[ChatSQLiteDB.sharedInstance.pDataArray objectAtIndex:indexPath.row] iCellNumber];
    
    CGSize windowSize = self.pChatTableView.frame.size;
    
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


@end
