//
//  ViewController.m
//  SQLLiteAndFMDB
//
//  Created by 顏逸修 on 2023/4/8.
//

#import "LoginViewController.h"
#import "UserData.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize accountTetxFeild;
@synthesize passwordTextFeild;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
