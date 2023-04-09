//
//  Mapper.m
//  SQLLiteAndFMDB
//
//  Created by 顏逸修 on 2023/4/9.
//

#import "Mapper.h"

@implementation Mapper

- (Mapper *)init {
    NSString *fileName = @"UserData";
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileName];
    return [self initWithFileName:fileName FilePath:filePath];
}


- (Mapper *)initWithFileName:(NSString *)FileName FilePath:(NSString *)FilePath {
    if (!self) {
        return self;
    }
    
    self = [super init];
    
    fileName = FileName;
    filePath = FilePath;
    
    return self;
}


+ (Mapper *)new {
    NSString *fileName = @"UserData";
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileName];
    return [[self class] newWithFileName: fileName FilePath: filePath];
}


+ (Mapper *)newWithFileName:(NSString *)FileName FilePath:(NSString *)FilePath {
    return [[[self class] alloc] initWithFileName:FileName FilePath:FilePath];
}


- (void) createTable {
    
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:filePath]) {
        
        if ([fmdbDatabase open]) {
            NSString *sql = @"CREATE TABLE IF NOT EXISTS UserData(USER_ID integer PRIMARY KEY AUTOINCREMENT, Account text NOT NULL, Password text NOT NULL)";
            [fmdbDatabase executeStatements:sql];
            NSLog(@"file copy to: %@",filePath);
        }
        
    } else {
        NSLog(@"DID-NOT copy db file, file allready exists at path:%@", filePath);
    }
}


-(BOOL) openConnection {
    BOOL isOpen = NO;
    return YES;
}

@end
