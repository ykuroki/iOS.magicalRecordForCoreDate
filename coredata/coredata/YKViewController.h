//
//  YKViewController.h
//  coredata
//
//  Created by Yuki Kuroki on 2014/08/21.
//  Copyright (c) 2014年 YUKI KUROKI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
- (IBAction)addBtnAction:(id)sender;
- (IBAction)deleteBtnAction:(id)sender;

@end
