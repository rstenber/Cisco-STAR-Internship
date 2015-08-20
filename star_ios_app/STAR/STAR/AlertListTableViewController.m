
//
//  AlertListTableViewController.m
//  STAR
//
//  Created by rstenber on 7/7/15.
//  Copyright (c) 2015 rstenber. All rights reserved.
//

#import "AlertListTableViewController.h"


@interface AlertListTableViewController ()

@end

@implementation AlertListTableViewController

@synthesize alertArray;
@synthesize titleLabel;
@synthesize currentUser;

@synthesize toolArray;
@synthesize XEDevlineArray;

@synthesize adminArray;
@synthesize permissionToEditAlert;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    alertArray = [[NSMutableArray alloc] initWithObjects:nil];
    XEDevlineArray = [[NSMutableArray alloc] initWithObjects:@"Any", nil];
    toolArray = [[NSMutableArray alloc] initWithObjects:@"ACME",@"CCA",@"EZCommit",@"NXOS Build",@"S2C",@"XE_Build",@"XR_Build", nil];
    permissionToEditAlert = [[NSMutableArray alloc] init];
    adminArray = [[NSArray alloc] initWithObjects:@"rstenber", @"devarbha", @"gopasing", @"hlavana", @"jofreema",@"lvadlamu", @"mjavaid", @"rost", @"tedhaliw", @"waseeahm", nil];
    
    //**************************************//
    //****** Setting the Title Label *******//
    //**************************************//
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.navigationController.navigationBar.center.x - 150, 0, 300, 50)];
    titleLabel.text = @"Alert Configurations";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.navigationController.navigationBar addSubview:titleLabel];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}




- (void)viewWillAppear:(BOOL)animated   {
    titleLabel.text = @"Alert Configurations";
}




// The following code adds an alert to the alertArray and alertTable
- (void) addAlertTool:(NSMutableString*)tool AlertID:(NSMutableString*)alertID Devline:(NSMutableString*)devline ImageName:(NSMutableString*)imageName Threshold:(NSMutableString*)threshold Default:(NSMutableString*)default_  {
    @autoreleasepool {
        
        alert *newAlert = [[alert alloc] initWithAlertTool:tool AlertID:alertID Devline:devline ImageName:imageName Threshold:threshold Default:default_];
        [alertArray addObject:(alert*) newAlert];
        [self.tableView reloadData];
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return alertArray.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"alertCell"];
    
    // Configure the cell...
    NSInteger rowNumber = indexPath.row;
    alert *tableAlert = alertArray[rowNumber];
    
    NSMutableString *tool = tableAlert.tool;
    NSMutableString *devline = tableAlert.devline;
    NSMutableString *imageName = tableAlert.imageName;
    NSMutableString *threshold = tableAlert.threshold;
    
    NSString *cellText = [NSString stringWithFormat:@"%@   -   %@", tool, threshold];
    NSString *cellDetailText = [NSString stringWithFormat:@"Devline: %@ - Image Name: %@", devline, imageName];
    
    [cell.textLabel setText:cellText];
    [cell.detailTextLabel setText:cellDetailText];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [permissionToEditAlert removeAllObjects];
        [permissionToEditAlert addObjectsFromArray:adminArray];
        
        //**************************************//
        //*** Check user permission to edit ****//
        //**************************************//
        NSMutableString *toolName = [[NSMutableString alloc] initWithString:@""];
        for (int i = 0; i < [self.tableView cellForRowAtIndexPath:indexPath].textLabel.text.length; i++)    {
            if ([[[self.tableView cellForRowAtIndexPath:indexPath].textLabel.text substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"-"])   {
                toolName = [NSMutableString stringWithString:[toolName substringWithRange:NSMakeRange(0, i - 3)]];
                break;
            }
            else    {
                toolName = [NSMutableString stringWithString:[toolName stringByAppendingString:[[self.tableView cellForRowAtIndexPath:indexPath].textLabel.text substringWithRange:NSMakeRange(i, 1)]]];
            }
        }
        NSString *urlString = [NSString stringWithFormat:@"http://star-vip.cisco.com:9001/model/tool/%@", toolName];
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
                UIAlertView *errorMessage2 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Tool Specifications cannot be converted to NSDictionary" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [errorMessage2 show];
            }
        }
        else    {   /* Set up an error message because the passed data is not a JSON */
            UIAlertView *errorMessage3 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Data was not in JSON format" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errorMessage3 show];
        }
        int permissionCheck = 0;
        for (int i = 0; i < permissionToEditAlert.count; i++)   {
            if ([(NSString*)(permissionToEditAlert[i]) isEqualToString:currentUser]) {
                // Delete the row from the data source
                NSInteger rowDeleted = indexPath.row;
                [alertArray removeObjectAtIndex:rowDeleted];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                permissionCheck++;
            }
        }
        if (permissionCheck == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Inadequate Permission"
                                                            message:@"You do not have permission to add an alert configuration for this tool"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    alert *tempAlert = alertArray[fromIndexPath.row];
    alertArray[fromIndexPath.row] = alertArray[toIndexPath.row];
    alertArray[toIndexPath.row] = tempAlert;
}


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
    if ([segue.identifier isEqualToString:@"addAlertSegue"]) {
        titleLabel.text = @"Add an Alert Configuration";
        AddAlertViewController *newAddAlertViewController = [segue destinationViewController];
        [newAddAlertViewController setMyAlertListTableViewController:self];
    }   else if ([segue.identifier isEqualToString:@"detailSegue"]) {
        titleLabel.text = @"Alert Configuration Details";
        
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        NSInteger selectedRow = selectedIndexPath.row;
        alert *selectedAlert = alertArray[selectedRow];
        
        DetailsViewController *newDetailsViewController = [segue destinationViewController];
        [newDetailsViewController setMyAlertListTableViewController:self];
    
        newDetailsViewController.alertTool      = selectedAlert.tool;
        newDetailsViewController.alertID        = selectedAlert.alertID;
        newDetailsViewController.alertDevline   = selectedAlert.devline;
        newDetailsViewController.alertImageName = selectedAlert.imageName;
        newDetailsViewController.alertThreshold = selectedAlert.threshold;
        newDetailsViewController.alertDefault   = selectedAlert.default_;
        
        newDetailsViewController.rowSelected = [self.tableView indexPathForSelectedRow].row;
    }
}


// ********************************************************** //
// ************** Handling Incomming Data  ****************** //
// ********************************************************** //

- (void)deleteData  {
    [alertArray removeAllObjects];
}

- (void)loadAlertConfigurations:(NSMutableDictionary*)dictionary    {
    for (id key in dictionary)  {
        alert *newAlertConfiguration = [[alert alloc] initWithAlertTool:[[dictionary objectForKey:key] objectForKey:@"tool"] AlertID:[[dictionary objectForKey:key] objectForKey:@"alert_id"] Devline:[[[dictionary objectForKey:key] objectForKey:@"conditions"] objectForKey:@"devline"] ImageName:[[[dictionary objectForKey:key] objectForKey:@"conditions"] objectForKey:@"image_name"] Threshold:[[[dictionary objectForKey:key] objectForKey:@"conditions"] objectForKey:@"threshold"] Default:[[dictionary objectForKey:key] objectForKey:@"default"]];
        [alertArray addObject:newAlertConfiguration];
    }
    [self.tableView reloadData];
}

- (void)loadDevlines:(NSMutableDictionary*)dictionary   {
    for (id key in dictionary)
        [XEDevlineArray addObject:[[dictionary objectForKey:key] objectForKey:@"devline"]];
}


@end
