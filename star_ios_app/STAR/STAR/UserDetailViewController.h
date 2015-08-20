//
//  UserDetailViewController.h
//  STAR
//
//  Created by rstenber on 8/17/15.
//  Copyright (c) 2015 rstenber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *ImageNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *HostTextField;
@property (weak, nonatomic) IBOutlet UITextField *BuildStartTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField *BuildTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField *UserIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *LogPathTextField;
@property (weak, nonatomic) IBOutlet UITextField *BranchTextField;
@property (weak, nonatomic) IBOutlet UITextField *ThresholdTextField;

@property (strong, nonatomic) NSString *ImageName;
@property (strong, nonatomic) NSString *Host;
@property (strong, nonatomic) NSString *BuildTimeStart;
@property (strong, nonatomic) NSString *BuildTime;
@property (strong, nonatomic) NSString *UserID;
@property (strong, nonatomic) NSString *LogPath;
@property (strong, nonatomic) NSString *Branch;
@property (strong, nonatomic) NSString *Threshold;

@end
