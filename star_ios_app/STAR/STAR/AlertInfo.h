//
//  AlertInfo.h
//  STAR
//
//  Created by rstenber on 7/20/15.
//  Copyright (c) 2015 rstenber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AlertInfo : NSManagedObject

@property (nonatomic, retain) NSString * alertTool;
@property (nonatomic, retain) NSString * alertType;
@property (nonatomic, retain) NSNumber * hourThreshold;
@property (nonatomic, retain) NSNumber * minuteThreshold;
@property BOOL notifyBuildTime;
@property BOOL notifyBuildFail;

@end
