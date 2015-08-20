//
//  NavigationViewController.m
//  STAR
//
//  Created by rstenber on 8/11/15.
//  Copyright (c) 2015 rstenber. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController
@synthesize appDelegate;
@synthesize myAlertListTableViewController;
@synthesize results;
@synthesize userProfile;


// Call back delegate method, lets the client app when the login attempt is failed.
-(void)authenticationError:(NSString *)errorTitle andDescription:(NSString *)errorDescription
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:errorTitle
                                                    message:[NSString stringWithFormat:@"%@",errorDescription]
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
// Call back delegate method, lets the client app to continue with application flow after successfull login.
// Client app must implement this delegate.




- (void)authorized
{
    // Once the login is successfull, Lets the user to view the app dashboard (or) next view in the app flow.
    // finish up
    NSLog(@"User has signed in");
    AuthController *auth = [AuthController sharedInstance];
    if ([auth isSignedIn])
        userProfile = [auth getUserProfile];
    NSString *currentUserID = @"rstenber"; //[userProfile objectForKey:@"uid"]; FIX to dynamically input userid
    ((AlertListTableViewController*)((self.viewControllers)[0])).currentUser = [NSMutableString stringWithString:currentUserID];
    [self receiveData];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = self.view.center;
    [spinner startAnimating];
}



- (void)receiveData {
    
    [(AlertListTableViewController*)((self.viewControllers)[0]) deleteData];
    
    //**************************************//
    //**** Receive Alert Configurations ****//
    //**************************************//
    NSURL *existingStarAlerts = [[NSURL alloc] initWithString:@"http://star-vip.cisco.com:9001/model/alerts/XE_Build"];
    NSData *returnedData = [NSData dataWithContentsOfURL:existingStarAlerts];
    
    if (NSClassFromString(@"NSJSONSerialization"))  {
        NSError *error = nil;
        NSArray *object = [NSJSONSerialization JSONObjectWithData:returnedData options:NSJSONReadingMutableContainers error:&error];
        NSMutableDictionary *dictionaryObject = [self indexKeyedDictionaryFromArray:object];
        
        
        if (error)  {   /* JSON was malformed, act appropriately here */
            UIAlertView *errorMessage1 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"JSON received was malformed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errorMessage1 show];
        }
        if ([dictionaryObject isKindOfClass:[NSMutableDictionary class]]) {
            results = dictionaryObject;
            [(AlertListTableViewController*)((self.viewControllers)[0]) loadAlertConfigurations:results];
        }
        else    {   /* Set up an error message because the JSON formatting does not comply with NSDictionary formatting */
            UIAlertView *errorMessage2 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Alert format cannot be converted to NSDictionary" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errorMessage2 show];
        }
    }
    else    {   /* Set up an error message because the passed data is not a JSON */
        UIAlertView *errorMessage3 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Data was not in JSON format" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorMessage3 show];
    }
    
    //**************************************//
    //******* Receive Devline List *********//
    //**************************************//
    NSURL *currentDevlineList =[[NSURL alloc] initWithString:@"http://star-vip.cisco.com:9001/get_data/xe_build/images/list/1439424000000/1439424000000"];
    // FIX to input devlines for other tools (not just XE)
    returnedData = [NSData dataWithContentsOfURL:currentDevlineList];
    
    if (NSClassFromString(@"NSJSONSerialization"))  {
        NSError *error = nil;
        NSArray *object = [NSJSONSerialization JSONObjectWithData:returnedData options:NSJSONReadingMutableContainers error:&error];
        NSMutableDictionary *dictionaryObject = [self indexKeyedDictionaryFromArray:object];
        
        if (error)  {   /* JSON was malformed, act appropriately here */
            UIAlertView *errorMessage1 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"JSON received was malformed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errorMessage1 show];
        }
        if ([dictionaryObject isKindOfClass:[NSMutableDictionary class]]) {
            [(AlertListTableViewController*)((self.viewControllers)[0]) loadDevlines:dictionaryObject];
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
    
    [self popViewControllerAnimated:YES];
    [self.tabBarController setSelectedIndex:0];
    self.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
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
    AuthController *auth = [AuthController sharedInstance];
    if (![auth isSignedIn])
        [self userStatusChanged];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    userProfile = [[NSDictionary alloc] init];
    [self.navigationBar setBarTintColor:[[UIColor alloc] initWithRed:32.0 / 255.0 green:94.0 / 255.0 blue:188.0 / 255.0 alpha:1]];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
    [self flowManager];
}


- (void)flowManager {
    AuthController *auth = [AuthController sharedInstance];
    auth.delegate = self;
    [auth initialize];
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    if ([auth._grantType isEqualToString:@"oauth"])
    {
        if ([auth._grantType isEqualToString:@"authorization_code"])
        {
            /** Authorization Code */
            // Logic to switch between login view, Passcode View and app dashboard view based on authentication status.
            appDelegate.window.rootViewController = auth.isSignedIn? self.tabBarController: auth;
        }
        else
        {
            NSLog(@"Configure App with a valid Authentication Grant Type to enable the Login View flow");
            appDelegate.window.rootViewController = self.tabBarController;
        }
    }
    
    [appDelegate.window makeKeyAndVisible];
}



-(void)userStatusChanged
{
    AuthController *auth = [AuthController sharedInstance];
    if ([auth isSignedIn])
        [auth logOut];
    self.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    [self pushViewController:auth animated:YES];
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

@end
