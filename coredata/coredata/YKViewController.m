//
//  YKViewController.m
//  coredata
//
//  Created by Yuki Kuroki on 2014/08/21.
//  Copyright (c) 2014年 YUKI KUROKI. All rights reserved.
//

#import "YKViewController.h"
#import "YKUserTableViewController.h"
#import "User.h"

@interface YKViewController (){
    YKUserTableViewController *vc;
    NSArray *users;
}

@end

@implementation YKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.nameField.delegate = self;
    self.addressField.delegate = self;

    // データ表示
    users = [User MR_findAll];
    vc.userList = users;
    [vc.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"userTableEmbedSegue"])
    {
        vc = (YKUserTableViewController *) [segue destinationViewController];
        vc.userList = users;
    }
}

- (IBAction)addBtnAction:(id)sender {
    NSString *name = self.nameField.text;
    NSString *address = self.addressField.text;

    if ([name length]==0 && [address length]==0) {

        return;
    }
    
    // データ保存
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext){

        //バックグランドスレッドで実行
        User *user = [User MR_createInContext:localContext];
        user.name   = name;
        user.address = address;
        
    } completion:^(BOOL success, NSError *error) {

        //保存後の処理(全件取得や件数カウントなど)
        users = [User MR_findAll];
        vc.userList = users;
        [vc.tableView reloadData];
        
    }];

}

- (IBAction)deleteBtnAction:(id)sender {
    NSManagedObjectContext *magicalContext = [NSManagedObjectContext MR_defaultContext];
    NSArray *all = [User MR_findAll];
    NSUInteger len = [all count];
    for ( int i = 0 ; i < len ; i++ ) {
        User *user = [all objectAtIndex:i];
        [user MR_deleteEntity];
    }

    [magicalContext MR_saveOnlySelfAndWait];
    [vc.tableView reloadData];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [self.addressField resignFirstResponder];
    [self.nameField resignFirstResponder];
    return YES;
}

@end
