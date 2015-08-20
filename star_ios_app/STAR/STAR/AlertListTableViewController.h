//
//  AlertListTableViewController.h
//  STAR
//
//  Created by rstenber on 7/7/15.
//  Copyright (c) 2015 rstenber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddAlertViewController.h"
#import "DetailsViewController.h"


@interface AlertListTableViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray *alertArray;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) NSMutableString *currentUser;

@property (nonatomic,strong) NSMutableArray *toolArray;
@property (nonatomic,strong) NSMutableArray *XEDevlineArray;

@property (strong, nonatomic) NSArray *adminArray;
@property (strong, nonatomic) NSMutableArray *permissionToEditAlert;

- (void) addAlertTool:(NSMutableString*)tool AlertID:(NSMutableString*)alertID Devline:(NSMutableString*)devline ImageName:(NSMutableString*)imageName Threshold:(NSMutableString*)threshold Default:(NSMutableString*)default_;
- (void)deleteData;
- (void)loadAlertConfigurations:(NSMutableDictionary*)dictionary;
- (void)loadDevlines:(NSMutableDictionary*)dictionary;

@end
