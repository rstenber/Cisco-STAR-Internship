//
//  userAlert.m
//  STAR
//
//  Created by rstenber on 8/17/15.
//  Copyright (c) 2015 rstenber. All rights reserved.
//

#import "userAlert.h"

@implementation userAlert

@synthesize imageName;
@synthesize host;
@synthesize buildStartTime;
@synthesize buildTime;
@synthesize userID;
@synthesize logPath;
@synthesize branch;
@synthesize threshold;

- (id)initWithImageName:(NSString*)image_name Host:(NSString*)_host BuildStartTime:(NSString*)build_start_time BuildTime:(NSString*)build_time UserID:(NSString*)user_id LogPath:(NSString*)log_path Branch:(NSString*)_branch Threshold:(NSString*)_threshold   {
    self = [super init];
    
    imageName = image_name;
    host = _host;
    buildStartTime = build_start_time;
    buildTime = build_time;
    userID = user_id;
    logPath = log_path;
    branch = _branch;
    threshold = _threshold;
    
    return self;
}

@end
