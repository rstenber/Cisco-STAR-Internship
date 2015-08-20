//
//  UserAlertsTableViewController.m
//  STAR
//
//  Created by rstenber on 8/17/15.
//  Copyright (c) 2015 rstenber. All rights reserved.
//

#import "UserAlertsTableViewController.h"

@implementation UserAlertsTableViewController
@synthesize titleLabel;

@synthesize timeFramePickerView;
@synthesize tap;

@synthesize mySearchController;
@synthesize searchString;
@synthesize searchedArray;

@synthesize alertArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    alertArray = [[NSMutableArray alloc] init];
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPickerView)];
    
    [self.navigationController.navigationBar setBarTintColor:[[UIColor alloc] initWithRed:32.0 / 255.0 green:94.0 / 255.0 blue:188.0 / 255.0 alpha:1]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    //**************************************//
    //****** Setting the Title Label *******//
    //**************************************//
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.navigationController.navigationBar.center.x - 50, 0, 100, 50)];
    titleLabel.text = @"My Alerts";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.navigationController.navigationBar addSubview:titleLabel];
    
    //**************************************//
    //****** Handling the Search Bar *******//
    //**************************************//
    mySearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    mySearchController.searchBar.placeholder = @"Set Time Range";
    mySearchController.searchResultsUpdater = self;
    mySearchController.dimsBackgroundDuringPresentation = NO;
    [mySearchController.searchBar setShowsScopeBar:YES];
    mySearchController.searchBar.delegate = self;
    [mySearchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = mySearchController.searchBar;
    self.definesPresentationContext = YES;
    
    
    
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    int currentTimeInt = (int)currentTime;
    NSString *currentTimeString = [[NSString alloc] initWithFormat:@"%d", currentTimeInt];
    NSDate *pastDate = [[NSDate alloc] initWithTimeIntervalSinceNow:- 3600*24*2];
    NSTimeInterval startTime = [pastDate timeIntervalSince1970];
    int startDateInt = (int)startTime;
    NSString *startTimeString = [[NSString alloc] initWithFormat:@"%d", startDateInt];
    
    [self receiveAlertListForStartTime:startTimeString andEndTime:currentTimeString andUserID:@"devar"];
    // FIX to use a dynamic userProfile
    [self.tableView reloadData];
}







- (void)receiveAlertListForStartTime:(NSString*)startTime andEndTime:(NSString*)endTime andUserID:(NSString*)userID    {
    [alertArray removeAllObjects];
    
    NSString *urlString = @"http://rtp-star-v001.cisco.com:9661/get_data/alerts/devarbha/1439856000000/1439856000000";
    //NSString *urlString = [[NSString alloc] initWithFormat:@"http://rtp-star-v001.cisco.com:9661/get_data/alerts/%@/%@/%@", userID, startTime, endTime];
    // FIX to use a dynamic userProfile and time
    NSURL *currentDevlineList =[[NSURL alloc] initWithString:urlString];
    NSData *returnedData = [NSData dataWithContentsOfURL:currentDevlineList];
    
    if (NSClassFromString(@"NSJSONSerialization"))  {
        NSError *error = nil;
        NSArray *object = [NSJSONSerialization JSONObjectWithData:returnedData options:NSJSONReadingMutableContainers error:&error];
        NSMutableDictionary *dictionaryObject = [self indexKeyedDictionaryFromArray:object];
        
        if (error)  {   /* JSON was malformed, act appropriately here */
            UIAlertView *errorMessage1 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"JSON received was malformed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errorMessage1 show];
        }
        if ([dictionaryObject isKindOfClass:[NSMutableDictionary class]]) {
            for (id key in dictionaryObject)    {
                NSDictionary *individualAlert = [dictionaryObject objectForKey:key];
                
                NSString *image_name = [[NSString alloc] initWithFormat:@"%@", [individualAlert objectForKey:@"Image"]];
                NSString *host = [[NSString alloc] initWithFormat:@"%@", [individualAlert objectForKey:@"Host"]];
                NSString *build_start_time = [[NSString alloc] initWithFormat:@"%@", [individualAlert objectForKey:@"StartTime"]];
                NSString *build_time = [[NSString alloc] initWithFormat:@"%@", [individualAlert objectForKey:@"BuildTime"]];
                NSString *user_id = [[NSString alloc] initWithFormat:@"%@", [individualAlert objectForKey:@"User"]];
                NSString *log_path = [[NSString alloc] initWithFormat:@"%@", [individualAlert objectForKey:@"LogPath"]];
                NSString *branch = [[NSString alloc] initWithFormat:@"%@", [individualAlert objectForKey:@"branch"]];
                NSString *threshold = [[NSString alloc] initWithFormat:@"%@", [individualAlert objectForKey:@"threshold"]];
                
                userAlert *individualUserAlert = [[userAlert alloc] initWithImageName:image_name Host:host BuildStartTime:build_start_time BuildTime:build_time UserID:user_id LogPath:log_path Branch:branch Threshold:threshold];
                
                [alertArray addObject:individualUserAlert];
            }
        }
        else    {   /* Set up an error message because the JSON formatting does not comply with NSDictionary formatting */
            UIAlertView *errorMessage2 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Devline List cannot be converted to NSArray" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errorMessage2 show];
        }
    }
    else    {   /* Set up an error message because the passed data is not a JSON */
        UIAlertView *errorMessage3 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Data was not in JSON format" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorMessage3 show];
    }
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




- (void)viewWillAppear:(BOOL)animated   {
    titleLabel.text = @"My Alerts";
}

- (BOOL)shouldAutorotate    {
    return NO;
}


- (void)didMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}





// Return the number of rows in the section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([mySearchController isActive])
        return alertArray.count + 1;
    else
        return alertArray.count;
}






// Open detail view controller for selected cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // FIX by following Segue to alert detail
    if ([mySearchController isActive] && indexPath.row == 0) {
        return;
    }
    else    {
        [self performSegueWithIdentifier:@"detailSegue" sender:self];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([mySearchController isActive] && indexPath.row == 0)
        return 200.0;
    else
        return 40.0;
}





// Create the cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    NSLog(@" %s", [mySearchController isActive] ? "true" : "false");
    if ([mySearchController isActive] && indexPath.row == 0) {
        //**************************************//
        //******* Time Frame Picker View *******//
        //**************************************//
        timeFramePickerView = [[UIPickerView alloc] init];
        timeFramePickerView.delegate = self;
        timeFramePickerView.dataSource = self;
        timeFramePickerView.hidden = NO;
        [cell addSubview:timeFramePickerView];
        [timeFramePickerView sizeToFit];
        NSString *rowToSelect = [[NSString alloc] init];
        if ([searchString isEqualToString:@"No time restrictions"])
            rowToSelect = @"0";
        else if ([searchString isEqualToString:@"1 day"])
            rowToSelect = @"1";
        else if (![searchString isEqualToString:@""] && ![searchString isEqualToString:nil])
            rowToSelect = [searchString stringByReplacingOccurrencesOfString:@" days" withString:@""];
        int row = [rowToSelect intValue];
        [timeFramePickerView selectRow:row inComponent:0 animated:YES];
    }
    else    {
        userAlert *userAlertProfile;
        if ([mySearchController isActive])
            userAlertProfile = (userAlert*)alertArray[indexPath.row - 1];
        else
            userAlertProfile = (userAlert*)alertArray[indexPath.row];
        
        NSString *textForCell = [[NSString alloc] initWithFormat:@"%@", userAlertProfile.imageName];
        
        NSString *detailTextForCell = [[NSString alloc] initWithFormat:@"Host: %@      Build Time: %@",userAlertProfile.host,userAlertProfile.buildTime];
        [cell.textLabel setText:textForCell];
        [cell.detailTextLabel setText:detailTextForCell];
        
        // FIX by creating proper alert cells
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}




//**************************************//
//********* Search Bar Methods *********//
//**************************************//
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    [mySearchController.searchBar sizeToFit];
    [self.tableView reloadData];
}



- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar    {
    [self.view addGestureRecognizer:tap];
    [mySearchController setActive:YES];
    [self.tableView reloadData];
}


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar  {
    [self.view removeGestureRecognizer:tap];
    [mySearchController setActive:NO];
    [self.tableView reloadData];
}





- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSString *currentTimeString = [[NSString alloc] init];
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    int currentTimeInt = (int)currentTime;
    currentTimeString = [NSString stringWithFormat:@"%d", currentTimeInt];
    NSString *startTimeString = [[NSString alloc] init];
    
    if ([searchText isEqualToString:@""] || [searchText isEqual:nil]) {
        NSDate *pastDate = [[NSDate alloc] initWithTimeIntervalSinceNow:- 3600*24*2];
        NSTimeInterval startTime = [pastDate timeIntervalSince1970];
        int startDateInt = (int)startTime;
        startTimeString = [NSString stringWithFormat:@"%d", startDateInt];
    }
    else if ([searchText isEqualToString:@"No time restrictions"])   {
        NSDate *pastDate = [[NSDate alloc] initWithTimeIntervalSinceNow:- 3600*24*365];
        NSTimeInterval startTime = [pastDate timeIntervalSince1970];
        int startDateInt = (int)startTime;
        startTimeString = [NSString stringWithFormat:@"%d", startDateInt];
    }
    else   {
        NSString *numberOfDays = [[NSString alloc] initWithFormat:@"%@", [searchBar.text stringByReplacingOccurrencesOfString:@" day" withString:@""]];
        int numOfDays = [numberOfDays intValue];
        NSDate *pastDate = [[NSDate alloc] initWithTimeIntervalSinceNow:- 3600*24*numOfDays];
        NSTimeInterval startTime = [pastDate timeIntervalSince1970];
        int startDateInt = (int)startTime;
        startTimeString = [NSString stringWithFormat:@"%d", startDateInt];
    }
    [self receiveAlertListForStartTime:startTimeString andEndTime:currentTimeString andUserID:@"rstenber"];
    // FIX to use a dynamic user profile
}






// ********************************************************** //
// ********* Begining of Picker View Implementation ********* //
// ********************************************************** //

#pragma mark - Picker View Methods

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component  {
    mySearchController.searchBar.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    searchString = mySearchController.searchBar.text;
}




- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView  {
    return 1;
}






- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 32;
}






- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view    {
    UILabel *tView = (UILabel *)view;
    if (!tView) {
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont systemFontOfSize:14]];
        tView.adjustsFontSizeToFitWidth = YES;
        tView.minimumScaleFactor = 0.7;
    }
    if (row == 0)
        [tView setText:@"No time restriction"];
    else if (row == 1)
        [tView setText:@"1 day"];
    else    {
        NSString *timeFrame = [NSString stringWithFormat:@"%lu days", row];
        [tView setText:timeFrame];
    }
    tView.backgroundColor = [UIColor whiteColor];
    tView.textAlignment = NSTextAlignmentCenter;
    return tView;
}





- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component    {
    if (row == 0)
        return  @"No time restriction";
    else if (row == 1)
        return @"1 day";
    else    {
        NSString *timeFrame = [NSString stringWithFormat:@"%lu days", row];
        return timeFrame;
    }
}

- (void)dismissPickerView {
    [mySearchController setActive:NO];
    [self.tableView reloadData];
}

// ********************************************************** //
// *********** End of Picker View Implementation ************ //
// ********************************************************** //



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender    {
    if ([segue.identifier isEqualToString:@"detailSegue"])  {
        NSIndexPath *selectedAlert = [self.tableView indexPathForSelectedRow];
        NSInteger selectedRow = selectedAlert.row;
        userAlert *selectedUserAlert = (userAlert*)alertArray[selectedRow];
        
        UserDetailViewController *newUserDetailViewController = [segue destinationViewController];
        
        newUserDetailViewController.ImageName = selectedUserAlert.imageName;
        newUserDetailViewController.Host = selectedUserAlert.host;
        newUserDetailViewController.BuildTimeStart = selectedUserAlert.buildStartTime;
        newUserDetailViewController.BuildTime = selectedUserAlert.buildTime;
        newUserDetailViewController.UserID = selectedUserAlert.userID;
        newUserDetailViewController.LogPath = selectedUserAlert.logPath;
        newUserDetailViewController.Branch = selectedUserAlert.branch;
        newUserDetailViewController.Threshold = selectedUserAlert.threshold;
        
        titleLabel.text = @"Alert Details";
    }
}
@end
