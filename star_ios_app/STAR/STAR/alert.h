//
//  alert.h
//  STAR
//
//  Created by rstenber on 7/8/15.
//  Copyright (c) 2015 rstenber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface alert : NSObject

@property NSMutableString *tool;
@property NSMutableString *alertID;
@property NSMutableString *devline;
@property NSMutableString *imageName;
@property NSMutableString *threshold;
@property NSMutableString *default_;

- (id)initWithAlertTool:(NSMutableString*)alertTool AlertID:(NSMutableString*)alert_id Devline:(NSMutableString*)_devline ImageName:(NSMutableString*)image_name Threshold:(NSMutableString*)_threshold Default:(NSMutableString*)_default;

@end
