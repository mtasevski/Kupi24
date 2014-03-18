//
//  ViewController.m
//  Kupi24
//
//  Created by Milena Tasevski on 1/29/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "ProductDetail.h"
#import "Product.h"
#import "ProductCell.h"
#import "JSON.h"
#import "UIImageView+WebCache.h"

@implementation ViewController

@synthesize products, myTable, imageURLs;
#pragma mark - View lifecycle


#define IS_IPHONE ( [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"])
#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define IS_IPHONE_5 ( IS_IPHONE && IS_HEIGHT_GTE_568 )
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
   // self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
   // [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];

   // [self setNeedsStatusBarAppearanceUpdate];
    
    //if(IS_IPHONE_5)
    //{
      //  [self.view setFrame:CGRectMake(0, 0, 320, 568)];
    /*}
    else
    {
        [self.view setFrame:CGRectMake(0, 0, 320, 480)];
        
    }*/

    _products = [NSMutableArray arrayWithCapacity:200];

    UIImage *imgNav = [UIImage imageNamed:@"nav.png"];
    //[self.navigationController.navigationBar setBackgroundImage:imgNav forBarMetrics:
   //  UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.translucent = NO;
   /* refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh)
             forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    */
   /* pull = [[PullToRefreshView alloc] initWithScrollView:(UIScrollView *) self.myTable];
    [pull setDelegate:self];
    [self.myTable addSubview:pull];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pullToRefreshViewShouldRefresh:)
                                                name:UIApplicationWillEnterForegroundNotification object:nil];
    
   */
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
    
    NSLog(@"responseeeeeeeeeeEEEEE = %@", response);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [pageData appendData:data];
    
}

/*- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    
}*/

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
    
   // self.products = ;
    
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
    
    self.products = _products;
    NSLog(@"self.products = %@", self.products);
    
    //get image URLs
    // NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Images" ofType:@"plist"];
   /* NSMutableArray *imagePaths = [[NSMutableArray alloc] init];
    for (int i = 0; i < [products count]; i++) {
        [imagePaths addObject:[products objectAtIndex:i]];
    }
    //remote image URLs
    NSMutableArray *URLs = [NSMutableArray array];
    for (NSString *path in imagePaths)
    {
        NSURL *URL = [NSURL URLWithString:path];
        if (URL)
        {
            [URLs addObject:URL];
        }
        else
        {
            NSLog(@"'%@' is not a valid URL", path);
        }
    }
    self.imageURLs = URLs;*/
    
    [self.myTable reloadData];
   // [self.refreshControl endRefreshing];
    
}

-(void)refresh {
   
    NSLog(@"DO SOMETHING");
    NSURLRequest *pageRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://kupi24.mk/api/all.php"] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:4];
    
    pageConnection = [[NSURLConnection alloc] initWithRequest:pageRequest delegate:self];
    pageData = [[NSMutableData alloc] init];
    
    
    
}
/*
- (void)pullToRefreshViewShouldRefresh:(PullToRefreshView *)view {
    
    NSLog(@"DO SOMETHING");
    NSURLRequest *pageRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://kupi24.mk/api/all.php"] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:4];
    
    pageConnection = [[NSURLConnection alloc] initWithRequest:pageRequest delegate:self];
    pageData = [[NSMutableData alloc] init];
    
    [pull finishedLoading];
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.products count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	//selectedRow = [indexPath row];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowDetails"])
    {
        
        UITableViewCell *cell = (UITableViewCell*)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];

        ProductDetail *viewController = [segue destinationViewController];
        
        Product *pr = [self.products objectAtIndex:[indexPath row]];
        viewController.productID = pr.productId;
        viewController.product = pr;
       
    }
    

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"CELL FOR ROW");
  //  [tableView setSeparatorInset:UIEdgeInsetsZero];
    
    Product *product = [(self.products) objectAtIndex:[indexPath row]];

    static NSString *CellIdentifier = @"ProductCell";
    ProductCell *cell =  (ProductCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
    if (cell == nil) {
        cell = [[ProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSURL *url = [NSURL URLWithString:product.imgProduct];
    [cell.productImageView setImageWithURL:url
                   placeholderImage:[UIImage imageNamed:@"placeholder"]];
   
    [cell.nameLabel setTextColor:[UIColor colorWithRed:1 green:23.5/100 blue:18.8/100 alpha:1]];
    [cell.nameLabel setFont:[UIFont fontWithName:@"NeoSansProRegular" size:16]];
    cell.nameLabel.text = product.title;
    [cell.descriptionLabel setFont:[UIFont fontWithName:@"NeoSansProRegular" size:12]];
    cell.descriptionLabel.text = product.description;
    [cell.lblOldPrice setFont:[UIFont fontWithName:@"NeoSansProRegular" size:12]];
    [cell.lblOldPrice setTextColor:[UIColor grayColor]];
    
    cell.lblOldPrice.text = [NSString stringWithFormat:@"%@ ден.", product.oldPrice];
    cell.lblNewPrice.text = [NSString stringWithFormat:@"%@ ден.", product.novaCena];

    return cell;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}



@end
