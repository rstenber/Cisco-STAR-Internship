//
//  NavigationViewController.h
//  STAR
//
//  Created by rstenber on 8/11/15.
//  Copyright (c) 2015 rstenber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthController.h"
#import "AppDelegate.h"
#import "AlertListTableViewController.h"

@interface NavigationViewController : UINavigationController

@property (nonatomic,strong) AppDelegate *appDelegate;
@property (nonatomic,strong) AlertListTableViewController *myAlertListTableViewController;
@property (nonatomic,strong) NSMutableDictionary *results;
@property (nonatomic,strong) NSDictionary *userProfile;

- (void)flowManager;
- (void)receiveData;
- (NSMutableDictionary *) indexKeyedDictionaryFromArray:(NSArray *)array;

@end
