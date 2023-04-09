//
//  ViewController.m
//  SQLLiteAndFMDB
//
//  Created by 顏逸修 on 2023/4/8.
//

#import "LoginViewController.h"
#import "UserData.h"

@interface LoginViewController ()

@property (strong, nonatomic) FMDatabase *database;

@end

@implementation LoginViewController

@synthesize accountTetxFeild;
@synthesize passwordTextFeild;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createDatabaseAndTable];
    [self insertData];
    [self selectAllTable];
    
}


- (void) showAlert: (NSString *) title message: (NSString *) message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (IBAction)loginButtonPressed:(UIButton *)sender {
    
    if (accountTetxFeild == nil || passwordTextFeild == nil) {
        [self showAlert:@"Empty Data" message:@"Please enter your user data"];
        return;
    }
    
    NSString *account = accountTetxFeild.text;
    NSString *password = passwordTextFeild.text;
    
    NSString *accountCheck = [self checkAccount:account];
    
    if (![accountCheck isEqualToString: @"CORRECT"]) {
        [self showAlert:@"ACCOUNT ERROR" message:accountCheck];
        return;
    }
    
    NSString *passwordCheck = [self checkPasswrd:password];
    
    if (![passwordCheck isEqualToString:@"CORRECT"]) {
        [self showAlert:@"PASSWORD ERROR" message:passwordCheck];
        return;
    }

    NSLog(@"Finish !!");
    UserData *userData = [[UserData alloc] init];
    userData.account = account;
    userData.password = password;
    NSLog(@"%@",userData.password);
    // TODO: use database to check the account is exists or not.
    
}


- (NSString *) checkAccount: (NSString *) account {
    
    if ([account length] > 10) {
        return @"Account exceeds length";
    }
    
    if (![self inputFormatIsCorrect:account]) {
        return @"Account Format Error";
    }
    
    return @"CORRECT";
}


- (NSString *) checkPasswrd: (NSString *) password {
    if ([password length] > 16) {
        return @"Password Exceeds Length";
    }
    
    if (![self inputFormatIsCorrect:password]) {
        return @"Password Format Error";
    }
    
    return @"CORRECT";
}


- (BOOL) inputFormatIsCorrect: (NSString *) inputString {
    
    NSError *error = nil;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z0-9]" options:NSRegularExpressionCaseInsensitive error:&error];
    NSUInteger numberOfMatches = [regularExpression numberOfMatchesInString:inputString options:0 range:NSMakeRange(0, [inputString length])];
    
    return [inputString length] == numberOfMatches ? YES : NO;
}


// create database
- (void) createDatabaseAndTable {
    // 1. set file name
    NSString *fileName = @"UD.db";
    
    // 2. set file path
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileName];
    
    // 3. get the database
    _database = [FMDatabase databaseWithPath:filePath];
    
    // 4. check to see if database open success or not
    if ([_database open]) {
        // 5. if database open successful, create table
        // 5.1. set sql query
        NSString *sqlQuery = @"CREATE TABLE IF NOT EXISTS UserData(USER_ID integer PRIMARY KEY AUTOINCREMENT, Account text NOT NULL, Password text NOT NULL);";
        // set boolean result and check the sql query execute success or not
        BOOL result = [_database executeUpdate:sqlQuery];
        
        if (result) {
            NSLog(@"Create table successfully!, FilePath is %@",filePath);
        } else {
            NSLog(@"Failed to create table");
        }
    }
    
}

- (void) insertData {
    NSString *account = @"account";
    NSString *password = @"new1";
    
    NSString *sqlQuery = @"INSERT INTO UserData (Account, Password) VALUES (?,?);";
    [_database executeUpdate:sqlQuery, account, password];
    
    NSLog(@"Insert successfullly");
}


- (void) selectAllTable {
    FMResultSet *resultSet = [_database executeQuery:@"select * from UserData"];
    
    NSString *resultString = @"";
    
    while ([resultSet next]) {
        int idNum = [resultSet intForColumn:@"USER_ID"];
        NSString *name = [resultSet stringForColumn:@"Account"];
        NSString *pwd = [resultSet stringForColumn:@"Password"];
        NSString *rowString = [NSString stringWithFormat:@"USER_ID: %i, Account: %@, Password: %@", idNum, name, pwd];
        resultString = [resultString stringByAppendingString:rowString];
        NSLog(@"%@", rowString);
    }
    
    NSLog(@"%@",resultString);
}


// check to see if the user input in text field is match the limit or not.
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    NSString *inputString = [accountTetxFeild.text stringByReplacingCharactersInRange:range withString:string];
//    NSLog(@"%@",inputString);
//
//    NSUInteger numberOfMatches = [regularExpression numberOfMatchesInString:string options:0 range:NSMakeRange(0, [string length])];
//    NSLog(@"%lu",numberOfMatches);
//    return numberOfMatches == [string length] ? YES : NO;
//}

@end
