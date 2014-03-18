//
//  AppDelegate.m
//  Kupi24
//
//  Created by Milena Tasev on 1/29/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "Product.h"
#import "ViewController.h"
#import "JSON.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
  //  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
   // [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];

     [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Untitled-1.png"] forBarMetrics:UIBarMetricsDefault];
   
    
    deviceToken = [[NSData alloc] init];
    
     _products = [NSMutableArray arrayWithCapacity:200];

    NSURLRequest *pageRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://kupi24.mk/api/all.php"] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:4];
    pageConnection = [[NSURLConnection alloc] initWithRequest:pageRequest delegate:self];
    
    pageData = [[NSMutableData alloc] init];
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    

    return YES;
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)devToken
{
	NSLog(@"My token is: %@", devToken);
    deviceToken = devToken;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];        
    if(![defaults objectForKey:@"firstRun"])                             // ovde samo dodaj ! za da se povika samo prviot part
    {
                                                                            // i odkomentiraj ovie dve linii
        [defaults setObject:[NSDate date] forKey:@"firstRun"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSString * token = [NSString stringWithFormat:@"%@", deviceToken];
        token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
        token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
        token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
        
        NSString *post = [NSString stringWithFormat:@"deviceToken=%@", token];
        
        NSLog(@"POST = %@", post);
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"http://kupi24.mk/api/insertToken.php"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        (void) [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
    }
    
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}
		

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
    
    NSLog(@"responseeeeeeeeeeEEEEE = %@", response);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [pageData appendData:data];
    
    NSLog(@"data recived = %@", pageData);
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"Connection Failed!");    
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {	
	
    NSError *error;
    
    JSON = [[NSArray alloc]  init]; 
    JSON = [NSJSONSerialization JSONObjectWithData: pageData
                                           options: NSJSONReadingMutableContainers 
                                             error: &error];
    
    NSLog(@"JSON = %@", JSON);
    
    [self fillProducts];
    
}

- (void)fillProducts {
    
    Product *product;
    
    for (int i = 0; i < [JSON count]; i++) {
        
        product = [[Product alloc] init];
        product.title = [[[JSON objectAtIndex:i] objectForKey:@"item"] objectForKey:@"title"];
        product.description = [[[JSON objectAtIndex:i] objectForKey:@"item"] objectForKey:@"description"];
        product.productId = [[[JSON objectAtIndex:i] objectForKey:@"item"] objectForKey:@"productId"];
        product.imgProduct = [[[JSON objectAtIndex:i] objectForKey:@"item"] objectForKey:@"image"];   
        product.oldPrice = [[[JSON objectAtIndex:i] objectForKey:@"item"] objectForKey:@"oldPrice"];
        product.novaCena = [[[JSON objectAtIndex:i] objectForKey:@"item"] objectForKey:@"newPrice"];
        product.arrNumbers = [[JSON objectAtIndex:i] objectForKey:@"values"];
        
        NSLog(@"NUBBERS %@, %@", product.title, product.arrNumbers);
        [_products addObject:product];
        
    }
    
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
   // navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    

    ViewController *viewController = [[navigationController viewControllers] objectAtIndex:0];
    viewController.products = _products;
    [viewController.tableView reloadData];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
