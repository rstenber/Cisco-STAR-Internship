//
//  SettingsTableViewController.m
//  STAR
//
//  Created by rstenber on 8/7/15.
//  Copyright (c) 2015 rstenber. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "AlertListTableViewController.h"

@interface SettingsTableViewController ()

@end

@implementation SettingsTableViewController
@synthesize titleLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[[UIColor alloc] initWithRed:32.0 / 255.0 green:94.0 / 255.0 blue:188.0 / 255.0 alpha:1]];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    //**************************************//
    //****** Setting the Title Label *******//
    //**************************************//
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.navigationController.navigationBar.center.x - 150, 0, 300, 50)];
    titleLabel.text = @"Settings";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:titleLabel];
}





- (void)viewWillAppear:(BOOL)animated   {
    titleLabel.text = @"Settings";
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingsCell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSInteger rowNumber = indexPath.row;
    if (rowNumber == 0)
        cell.textLabel.text = @"Push Notifications";
    if (rowNumber == 1)
        cell.textLabel.text = @"Logout";
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    return cell;
}






- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger rowNumber = indexPath.row;
    if ([[[(UITableViewCell*)tableView.visibleCells[rowNumber] textLabel] text] isEqual:@"Logout"])   {
        AuthController *auth = [AuthController sharedInstance];
        [auth logOut];
        [self.tabBarController setSelectedIndex:1];
    }
    else if ([[[(UITableViewCell*)tableView.visibleCells[rowNumber] textLabel] text] isEqual:@"Push Notifications"])    {
        PushNotificationsTableViewController *myPushNotificationsTableViewController = [[PushNotificationsTableViewController alloc] init];
        [self.navigationController pushViewController:myPushNotificationsTableViewController animated:YES];
        titleLabel.text = @"Push Notifications";
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}





/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}


@end
