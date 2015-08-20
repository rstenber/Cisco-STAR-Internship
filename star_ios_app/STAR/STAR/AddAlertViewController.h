//
//  AddAlertViewController.h
//  STAR
//
//  Created by rstenber on 7/8/15.
//  Copyright (c) 2015 rstenber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "alert.h"

@class AlertListTableViewController;

@interface AddAlertViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) AlertListTableViewController *myAlertListTableViewController;

@property (weak, nonatomic) IBOutlet UITextField *toolTextField;
@property (weak, nonatomic) IBOutlet UITextField *devlineTextField;
@property (weak, nonatomic) IBOutlet UITextField *imageNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *thresholdTextField;

@property (weak, nonatomic) IBOutlet UIPickerView *toolPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *devlinePickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *imageNamePickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *thresholdPickerView;

@property (nonatomic, strong) NSMutableArray *dummyDevlineArray;
@property (nonatomic, strong) NSMutableArray *dummyImageNameArray;
@property (nonatomic, strong) NSMutableArray *ImageNameArray;
@property (nonatomic, strong) NSMutableArray *HoursArray;
@property (nonatomic, strong) NSMutableArray *MinutesArray;

@property (strong, nonatomic) NSArray *adminArray;
@property (strong, nonatomic) NSMutableArray *permissionToEditAlert;

- (IBAction)AddAlertButtonPressed:(id)sender;
- (NSMutableDictionary *) indexKeyedDictionaryFromArray:(NSArray *)array;

@end
