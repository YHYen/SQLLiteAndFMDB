//
//  UserData.h
//  SQLLiteAndFMDB
//
//  Created by 顏逸修 on 2023/4/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserData : NSObject

@property (strong, nonatomic, nonnull) NSString *account;
@property (strong, nonatomic, nonnull) NSString *password;

@end

NS_ASSUME_NONNULL_END
