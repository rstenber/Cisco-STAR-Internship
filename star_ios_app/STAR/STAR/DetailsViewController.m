//
//  DetailsViewController.m
//  STAR
//
//  Created by rstenber on 7/9/15.
//  Copyright (c) 2015 rstenber. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

@synthesize myAlertListTableViewController;

@synthesize alertTool;
@synthesize alertID;
@synthesize alertDevline;
@synthesize alertImageName;
@synthesize alertThreshold;
@synthesize alertDefault;

@synthesize rowSelected;

@synthesize toolTextField;
@synthesize devlineTextField;
@synthesize imageNameTextField;
@synthesize thresholdTextField;

@synthesize dummyDevlineArray;
@synthesize dummyImageNameArray;
@synthesize ImageNameArray;
@synthesize HoursArray;
@synthesize MinutesArray;

@synthesize devlinePickerView;
@synthesize imageNamePickerView;
@synthesize thresholdPickerView;

@synthesize adminArray;
@synthesize permissionToEditAlert;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dummyImageNameArray = [[NSMutableArray alloc] initWithObjects:@"Devline 1", @"Devline 2", @"Devline 3", nil];
    dummyImageNameArray = [[NSMutableArray alloc] initWithObjects:@"Image Name 1", @"Image Name 2", @"Image Name 3", nil];
    ImageNameArray = [[NSMutableArray alloc] initWithObjects:@"Any", nil];
    permissionToEditAlert = [[NSMutableArray alloc] init];
    adminArray = [[NSArray alloc] initWithObjects:@"rstenber", @"devarbha", @"gopasing", @"hlavana", @"jofreema",@"lvadlamu", @"mjavaid", @"rost", @"tedhaliw", @"waseeahm", nil];
    
    toolTextField.enabled = NO;
    devlineTextField.enabled = NO;
    imageNameTextField.enabled = NO;
    thresholdTextField.enabled = NO;
    
    //******************************
    //***** devlinePickerView ******
    //******************************
    devlinePickerView.hidden = YES;
    
    //******************************
    //***** imageNamePickerView ****
    //******************************
    imageNamePickerView.hidden = YES;
    
    //******************************
    //** ThresholdTimePickerView ***
    //******************************
    thresholdPickerView.hidden = YES;
    HoursArray = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24", nil];
    MinutesArray = [[NSMutableArray alloc] initWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",@"60", nil];
    
    //******************************
    //********* Alert Tool *********
    //******************************
    UILabel *toolLeftViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    toolLeftViewLabel.text = @"Tool: ";
    [toolLeftViewLabel setFont:[UIFont systemFontOfSize:14]];
    [toolLeftViewLabel setTextAlignment:NSTextAlignmentCenter];
    toolTextField.leftView = toolLeftViewLabel;
    toolTextField.leftViewMode = UITextFieldViewModeAlways;
    
    NSString *myAlertTool = [[NSString alloc] initWithString:alertTool];
    toolTextField.text = myAlertTool;
    
    //******************************
    //******* Alert Devline ********
    //******************************
    UILabel *devlineLeftViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    devlineLeftViewLabel.text = @"Devline: ";
    [devlineLeftViewLabel setFont:[UIFont systemFontOfSize:14]];
    [devlineLeftViewLabel setTextAlignment:NSTextAlignmentCenter];
    devlineTextField.leftView = devlineLeftViewLabel;
    devlineTextField.leftViewMode = UITextFieldViewModeAlways;
    
    NSString *myAlertDevline = [[NSString alloc] initWithString:alertDevline];
    devlineTextField.text = myAlertDevline;
    
    //******************************
    //****** Alert Image Name ******
    //******************************
    UILabel *imageNameLeftViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    imageNameLeftViewLabel.text = @"Image Name: ";
    [imageNameLeftViewLabel setFont:[UIFont systemFontOfSize:14]];
    [imageNameLeftViewLabel setTextAlignment:NSTextAlignmentCenter];
    imageNameTextField.leftView = imageNameLeftViewLabel;
    imageNameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    NSString *myAlertImageName = [[NSString alloc] initWithString:alertImageName];
    imageNameTextField.text = myAlertImageName;
    
    
    //******************************
    //********* Threshold **********
    //******************************
    UILabel *thresholdLeftViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    thresholdLeftViewLabel.text = @"Threshold: ";
    [thresholdLeftViewLabel setFont:[UIFont systemFontOfSize:14]];
    [thresholdLeftViewLabel setTextAlignment:NSTextAlignmentCenter];
    thresholdTextField.leftView = thresholdLeftViewLabel;
    thresholdTextField.leftViewMode = UITextFieldViewModeAlways;
    
    NSString *myAlertThreshold = [[NSString alloc] initWithString:alertThreshold];
    thresholdTextField.text = myAlertThreshold;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField    {
    [textField resignFirstResponder];
    [self.view endEditing:YES];
    
    if ([textField isEqual:devlineTextField])  {
        devlinePickerView.hidden = NO;
        imageNamePickerView.hidden = YES;
        thresholdPickerView.hidden = YES;
        return NO;
    }
    else if ([textField isEqual:imageNameTextField])    {
        //**************************************//
        //******** Receive Image Name **********//
        //**************************************//
        NSString *urlString = [NSString stringWithFormat:@"http://star-vip.cisco.com:9001/get_data/xe_build/details/1439424000000/1439424000000/%@", devlineTextField.text];
        NSURL *currentImageNameList =[[NSURL alloc] initWithString:urlString];
        NSData *returnedData = [NSData dataWithContentsOfURL:currentImageNameList];
        
        if (NSClassFromString(@"NSJSONSerialization"))  {
            NSError *error = nil;
            NSMutableDictionary *dictionaryObject = [NSJSONSerialization JSONObjectWithData:returnedData options:NSJSONReadingMutableContainers error:&error];
            
            if (error)  {   /* JSON was malformed, act appropriately here */
                UIAlertView *errorMessage1 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"JSON received was malformed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [errorMessage1 show];
            }
            if ([dictionaryObject isKindOfClass:[NSMutableDictionary class]]) {
                for (int i = 0; i < ((NSArray*)[dictionaryObject objectForKey:@"valid_images"]).count; i++)   {
                    [ImageNameArray addObject:((NSArray*)[dictionaryObject objectForKey:@"valid_images"])[i]];
                }
                [imageNamePickerView reloadAllComponents];
                imageNamePickerView.hidden = NO;
            }
            else    {   /* Set up an error message because the JSON formatting does not comply with NSDictionary formatting */
                UIAlertView *errorMessage2 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Image Name List cannot be converted to NSArray" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [errorMessage2 show];
            }
        }
        else    {   /* Set up an error message because the passed data is not a JSON */
            UIAlertView *errorMessage3 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Data was not in JSON format" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errorMessage3 show];
        }
        devlinePickerView.hidden = YES;
        imageNamePickerView.hidden = NO;
        thresholdPickerView.hidden = YES;
        return NO;
    }
    else if ([textField isEqual:thresholdTextField])    {
        NSString *currentThreshold = thresholdTextField.text;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"HH:mm";
        NSDate *timeDate = [formatter dateFromString:currentThreshold];
        
        formatter.dateFormat = @"HH";
        int hours = [[formatter stringFromDate:timeDate] intValue];
        formatter.dateFormat = @"mm";
        int minutes = [[formatter stringFromDate:timeDate] intValue];
        
        [thresholdPickerView selectRow:hours inComponent:0 animated:YES];
        [thresholdPickerView selectRow:minutes inComponent:1 animated:YES];
        
        devlinePickerView.hidden = YES;
        imageNamePickerView.hidden = YES;
        thresholdPickerView.hidden = NO;
        return NO;
    }
    return YES;
}




- (NSMutableDictionary *) indexKeyedDictionaryFromArray:(NSArray *)array
{
    id objectInstance;
    NSUInteger indexKey = 0U;
    
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
    for (objectInstance in array)
        [mutableDictionary setObject:objectInstance forKey:[NSNumber numberWithInteger:indexKey++]];
    
    return mutableDictionary;
}





-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



// ********************************************************** //
// ********* Begining of Picker View Implementation ********* //
// ********************************************************** //

#pragma mark - Picker View Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView  {
    if ([pickerView isEqual:thresholdPickerView])
        return 2;
    else
        return 1;
}






- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual:devlinePickerView])    {
        if ([toolTextField.text isEqualToString:@"XE_Build"])
            return myAlertListTableViewController.XEDevlineArray.count;
        else
            return dummyDevlineArray.count;
    }
    else if ([pickerView isEqual:imageNamePickerView])  {
        if ([toolTextField.text isEqualToString:@"XE_Build"])
            return ImageNameArray.count;
        else
            return dummyImageNameArray.count;
    }
    else if ([pickerView isEqual:thresholdPickerView])  {
        if (component == 0)
            return 25;
        else if (component == 1)
            return 61;
    }
    return 0;
}






- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component  {
    if ([pickerView isEqual:devlinePickerView])  {
        devlineTextField.text = [self pickerView:devlinePickerView titleForRow:[devlinePickerView selectedRowInComponent:0] forComponent:0];
    }
    else if ([pickerView isEqual:imageNamePickerView])  {
        imageNameTextField.text = [self pickerView:imageNamePickerView titleForRow:[imageNamePickerView selectedRowInComponent:0] forComponent:0];
    }
    else if ([pickerView isEqual:thresholdPickerView])  {
        thresholdTextField.text = [NSString stringWithFormat:@"%@:%@", [self pickerView:thresholdPickerView titleForRow:[thresholdPickerView selectedRowInComponent:0] forComponent:0], [self pickerView:thresholdPickerView titleForRow:[thresholdPickerView selectedRowInComponent:1] forComponent:1]];
    }
}





- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view    {
    UILabel *tView = (UILabel *)view;
    if (!tView) {
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont systemFontOfSize:15]];
        tView.adjustsFontSizeToFitWidth = YES;
        tView.minimumScaleFactor = 0.7;
    }
    
    if ([pickerView isEqual:devlinePickerView])    {
        if ([toolTextField.text isEqualToString:@"XE_Build"])
            tView.text = myAlertListTableViewController.XEDevlineArray[row];
        else
            tView.text = dummyDevlineArray[row];
    }
    else if ([pickerView isEqual:imageNamePickerView])  {
        if ([toolTextField.text isEqualToString:@"XE_Build"])
            tView.text = ImageNameArray[row];
        else
            tView.text = dummyImageNameArray[row];
    }
    else if ([pickerView isEqual:thresholdPickerView])  {
        if (component == 0)
            tView.text = HoursArray[row];
        else if (component == 1)
            tView.text = MinutesArray[row];
    }
    tView.textAlignment = NSTextAlignmentCenter;
    return tView;
}





- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component    {
    if ([pickerView isEqual:devlinePickerView])    {
        if ([toolTextField.text isEqualToString:@"XE_Build"])
            return myAlertListTableViewController.XEDevlineArray[row];
        else
            return dummyDevlineArray[row];
    }
    else if ([pickerView isEqual:imageNamePickerView])  {
        if ([toolTextField.text isEqualToString:@"XE_Build"])
            return ImageNameArray[row];
        else
            return dummyImageNameArray[row];
    }
    else if ([pickerView isEqual:thresholdPickerView])  {
        if (component == 0)
            return HoursArray[row];
        if (component == 1) {
            return MinutesArray[row];
        }
    }
    return @"";
}
// ********************************************************** //
// ************ End of Picker View Implementation *********** //
// ********************************************************** //




- (IBAction)editButtonPressed:(id)sender {
    
    [permissionToEditAlert removeAllObjects];
    [permissionToEditAlert addObjectsFromArray:adminArray];
    
    //**************************************//
    //*** Check user permission to edit ****//
    //**************************************//
    NSString *urlString = [NSString stringWithFormat:@"http://star-vip.cisco.com:9001/model/tool/%@", toolTextField.text];
    NSURL *toolSpecifications =[[NSURL alloc] initWithString:urlString];
    NSData *returnedData = [NSData dataWithContentsOfURL:toolSpecifications];
    
    if (NSClassFromString(@"NSJSONSerialization"))  {
        NSError *error = nil;
        NSMutableDictionary *dictionaryObject = [NSJSONSerialization JSONObjectWithData:returnedData options:NSJSONReadingMutableContainers error:&error];
        
        if (error)  {   /* JSON was malformed, act appropriately here */
            UIAlertView *errorMessage1 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"JSON received was malformed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errorMessage1 show];
        }
        if ([dictionaryObject isKindOfClass:[NSMutableDictionary class]]) {
            for (int i = 0; i < ((NSArray*)[dictionaryObject objectForKey:@"owners"]).count; i++)
                [permissionToEditAlert addObject:((NSArray*)[dictionaryObject objectForKey:@"owners"])[i]];
        }
        else    {   /* Set up an error message because the JSON formatting does not comply with NSDictionary formatting */
            UIAlertView *errorMessage2 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Image Name List cannot be converted to NSArray" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errorMessage2 show];
        }
    }
    else    {   /* Set up an error message because the passed data is not a JSON */
        UIAlertView *errorMessage3 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Data was not in JSON format" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorMessage3 show];
    }
    
    
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"Edit"]) {
        for (int i = 0; i < permissionToEditAlert.count; i++)   {
            if ([(NSString*)(permissionToEditAlert[i]) isEqualToString:myAlertListTableViewController.currentUser]) {
                devlineTextField.enabled = YES;
                imageNameTextField.enabled = YES;
                thresholdTextField.enabled = YES;
                [self.navigationItem.rightBarButtonItem setTitle: @"Save"];
                break;
            }
        }
        if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"Edit"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Inadequate Permission"
                                                            message:@"You do not have permission to edit an alert configuration for this tool"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    } else if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"Save"])  {
        
        devlineTextField.enabled = NO;
        imageNameTextField.enabled = NO;
        thresholdTextField.enabled = NO;
        devlinePickerView.hidden = YES;
        imageNamePickerView.hidden = YES;
        thresholdPickerView.hidden = YES;
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
        
        alert *edittedAlert = [[alert alloc] initWithAlertTool:alertTool AlertID:alertID Devline:(NSMutableString*)devlineTextField.text ImageName:(NSMutableString*)imageNameTextField.text Threshold:(NSMutableString*)thresholdTextField.text Default:alertDefault];
        
        self.myAlertListTableViewController.alertArray[rowSelected] = edittedAlert;
        [self.myAlertListTableViewController.tableView reloadData];
    }
}
@end
