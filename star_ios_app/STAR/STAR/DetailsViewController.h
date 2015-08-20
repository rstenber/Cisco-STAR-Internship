//
//  DetailsViewController.h
//  STAR
//
//  Created by rstenber on 7/9/15.
//  Copyright (c) 2015 rstenber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertListTableViewController.h"

@interface DetailsViewController : UIViewController

@property (strong, nonatomic) AlertListTableViewController *myAlertListTableViewController;

@property (strong, nonatomic) NSMutableString *alertTool;
@property (strong, nonatomic) NSMutableString *alertID;
@property (strong, nonatomic) NSMutableString *alertDevline;
@property (strong, nonatomic) NSMutableString *alertImageName;
@property (strong, nonatomic) NSMutableString *alertThreshold;
@property (strong, nonatomic) NSMutableString *alertDefault;

@property NSInteger rowSelected;

@property (weak, nonatomic) IBOutlet UITextField *toolTextField;
@property (weak, nonatomic) IBOutlet UITextField *devlineTextField;
@property (weak, nonatomic) IBOutlet UITextField *imageNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *thresholdTextField;

@property (nonatomic, strong) NSMutableArray *dummyDevlineArray;
@property (nonatomic, strong) NSMutableArray *dummyImageNameArray;
@property (nonatomic, strong) NSMutableArray *ImageNameArray;
@property (nonatomic, strong) NSMutableArray *HoursArray;
@property (nonatomic, strong) NSMutableArray *MinutesArray;

@property (weak, nonatomic) IBOutlet UIPickerView *devlinePickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *imageNamePickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *thresholdPickerView;

@property (strong, nonatomic) NSArray *adminArray;
@property (strong, nonatomic) NSMutableArray *permissionToEditAlert;

- (IBAction)editButtonPressed:(id)sender;
- (NSMutableDictionary *) indexKeyedDictionaryFromArray:(NSArray *)array;

@end
