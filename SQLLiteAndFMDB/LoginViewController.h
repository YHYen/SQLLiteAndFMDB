//
//  ViewController.h
//  SQLLiteAndFMDB
//
//  Created by 顏逸修 on 2023/4/8.
//

#import <UIKit/UIKit.h>
#import <SQLCipher/sqlite3.h>
#import <FMDB/FMDB.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *accountTetxFeild;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextFeild;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;


@end

