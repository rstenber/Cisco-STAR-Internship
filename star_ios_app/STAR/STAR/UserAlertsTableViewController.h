//
//  UserAlertsTableViewController.h
//  STAR
//
//  Created by rstenber on 8/17/15.
//  Copyright (c) 2015 rstenber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userAlert.h"
#import "UserDetailViewController.h"

@interface UserAlertsTableViewController : UITableViewController <UISearchBarDelegate, UISearchResultsUpdating, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIPickerView *timeFramePickerView;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@property (nonatomic,strong) UISearchController *mySearchController;
@property (nonatomic,strong) NSString *searchString;
@property (nonatomic,strong) NSMutableArray *searchedArray;

@property (nonatomic,strong) NSMutableArray *alertArray;

- (void)receiveAlertListForStartTime:(NSString*)startTime andEndTime:(NSString*)endTime andUserID:(NSString*)userID;

- (NSMutableDictionary *) indexKeyedDictionaryFromArray:(NSArray *)array;
@end
