//
//  UserDetailViewController.m
//  STAR
//
//  Created by rstenber on 8/17/15.
//  Copyright (c) 2015 rstenber. All rights reserved.
//

#import "UserDetailViewController.h"

@interface UserDetailViewController ()

@end

@implementation UserDetailViewController

@synthesize ImageNameTextField;
@synthesize HostTextField;
@synthesize BuildStartTimeTextField;
@synthesize BuildTimeTextField;
@synthesize UserIDTextField;
@synthesize LogPathTextField;
@synthesize BranchTextField;
@synthesize ThresholdTextField;

@synthesize ImageName;
@synthesize Host;
@synthesize BuildTimeStart;
@synthesize BuildTime;
@synthesize UserID;
@synthesize LogPath;
@synthesize Branch;
@synthesize Threshold;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //******************************
    //********* Image Name *********
    //******************************
    UILabel *imageNameLeftViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    imageNameLeftViewLabel.text = @"Image Name: ";
    [imageNameLeftViewLabel setFont:[UIFont systemFontOfSize:14]];
    [imageNameLeftViewLabel setTextAlignment:NSTextAlignmentCenter];
    ImageNameTextField.leftView = imageNameLeftViewLabel;
    ImageNameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    //******************************
    //************ Host ************
    //******************************
    UILabel *hostLeftViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    hostLeftViewLabel.text = @"Host: ";
    [hostLeftViewLabel setFont:[UIFont systemFontOfSize:14]];
    [hostLeftViewLabel setTextAlignment:NSTextAlignmentCenter];
    HostTextField.leftView = hostLeftViewLabel;
    HostTextField.leftViewMode = UITextFieldViewModeAlways;
    
    //******************************
    //****** Build Time Start ******
    //******************************
    UILabel *buildTimeStartLeftViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    buildTimeStartLeftViewLabel.text = @"Build Time Start: ";
    [buildTimeStartLeftViewLabel setFont:[UIFont systemFontOfSize:14]];
    [buildTimeStartLeftViewLabel setTextAlignment:NSTextAlignmentCenter];
    BuildStartTimeTextField.leftView = buildTimeStartLeftViewLabel;
    BuildStartTimeTextField.leftViewMode = UITextFieldViewModeAlways;
    
    //******************************
    //********* Build Time *********
    //******************************
    UILabel *buildTimeLeftViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    buildTimeLeftViewLabel.text = @"Build Time: ";
    [buildTimeLeftViewLabel setFont:[UIFont systemFontOfSize:14]];
    [buildTimeLeftViewLabel setTextAlignment:NSTextAlignmentCenter];
    BuildTimeTextField.leftView = buildTimeLeftViewLabel;
    BuildTimeTextField.leftViewMode = UITextFieldViewModeAlways;
    
    //******************************
    //********** User ID ***********
    //******************************
    UILabel *userIDLeftViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    userIDLeftViewLabel.text = @"User ID: ";
    [userIDLeftViewLabel setFont:[UIFont systemFontOfSize:14]];
    [userIDLeftViewLabel setTextAlignment:NSTextAlignmentCenter];
    UserIDTextField.leftView = userIDLeftViewLabel;
    UserIDTextField.leftViewMode = UITextFieldViewModeAlways;
    
    //******************************
    //********** Log Path **********
    //******************************
    UILabel *logPathLeftViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    logPathLeftViewLabel.text = @"Log Path: ";
    [logPathLeftViewLabel setFont:[UIFont systemFontOfSize:14]];
    [logPathLeftViewLabel setTextAlignment:NSTextAlignmentCenter];
    LogPathTextField.leftView = logPathLeftViewLabel;
    LogPathTextField.leftViewMode = UITextFieldViewModeAlways;
    
    //******************************
    //********** Branch ************
    //******************************
    UILabel *branchLeftViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    branchLeftViewLabel.text = @"Branch: ";
    [branchLeftViewLabel setFont:[UIFont systemFontOfSize:14]];
    [branchLeftViewLabel setTextAlignment:NSTextAlignmentCenter];
    BranchTextField.leftView = branchLeftViewLabel;
    BranchTextField.leftViewMode = UITextFieldViewModeAlways;
    
    //******************************
    //********* Threshold **********
    //******************************
    UILabel *thresholdLeftViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    thresholdLeftViewLabel.text = @"Threshold: ";
    [thresholdLeftViewLabel setFont:[UIFont systemFontOfSize:14]];
    [thresholdLeftViewLabel setTextAlignment:NSTextAlignmentCenter];
    ThresholdTextField.leftView = thresholdLeftViewLabel;
    ThresholdTextField.leftViewMode = UITextFieldViewModeAlways;
    
    ImageNameTextField.text = ImageName;
    HostTextField.text = Host;
    BuildStartTimeTextField.text = BuildTimeStart;
    BuildTimeTextField.text = BuildTime;
    UserIDTextField.text = UserID;
    LogPathTextField.text = LogPath;
    BranchTextField.text = Branch;
    ThresholdTextField.text = Threshold;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField    {
    return NO;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
