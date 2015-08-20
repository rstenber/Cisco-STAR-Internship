//
//  userAlert.h
//  STAR
//
//  Created by rstenber on 8/17/15.
//  Copyright (c) 2015 rstenber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userAlert : NSObject

@property NSString *imageName;
@property NSString *host;
@property NSString *buildStartTime;
@property NSString *buildTime;
@property NSString *userID;
@property NSString *logPath;
@property NSString *branch;
@property NSString *threshold;

- (id)initWithImageName:(NSString*)image_name Host:(NSString*)_host BuildStartTime:(NSString*)build_start_time BuildTime:(NSString*)build_time UserID:(NSString*)user_id LogPath:(NSString*)log_path Branch:(NSString*)_branch Threshold:(NSString*)_threshold;

@end
