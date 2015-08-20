//
//  alert.m
//  STAR
//
//  Created by rstenber on 7/8/15.
//  Copyright (c) 2015 rstenber. All rights reserved.
//

#import "alert.h"

@implementation alert

@synthesize tool;
@synthesize alertID;
@synthesize devline;
@synthesize imageName;
@synthesize threshold;
@synthesize default_;

- (id)initWithAlertTool:(NSMutableString*)alertTool AlertID:(NSMutableString*)alert_id Devline:(NSMutableString*)_devline ImageName:(NSMutableString*)image_name Threshold:(NSMutableString*)_threshold Default:(NSMutableString*)_default   {
    self = [super init];
    tool = alertTool;
    alertID = alert_id;
    devline = _devline;
    imageName = image_name;
    threshold = _threshold;
    default_ = _default;
    return self;
}

@end
