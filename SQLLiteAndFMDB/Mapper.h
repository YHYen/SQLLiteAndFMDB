//
//  Mapper.h
//  SQLLiteAndFMDB
//
//  Created by 顏逸修 on 2023/4/9.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface Mapper : NSObject {
    NSString* fileName;
    NSString* filePath;
    FMDatabase *fmdbDatabase;
}

- (Mapper *) init;
- (Mapper *) initWithFileName: (NSString *) FileName FilePath: (NSString *) FilePath;

+ (Mapper *) new;
+ (Mapper *) newWithFileName: (NSString *) FileName FilePath: (NSString *) FilePath;


- (void) createTable;
- (BOOL) openConnection;

@end

NS_ASSUME_NONNULL_END
