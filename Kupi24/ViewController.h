//
//  ViewController.h
//  Kupi24
//
//  Created by Milena Tasev on 1/29/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UITableViewController <NSURLConnectionDelegate> {
    
    int selectedRow;
    // PullToRefreshView *pull;
    
    NSMutableArray *_products;
    
    NSMutableData *responseData;
    NSMutableData *pageData;
    NSArray *JSON;
    NSURLConnection *pageConnection;
    
   // UIRefreshControl *refreshControl;
    
}

@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic, retain) IBOutlet UITableView *myTable;
@property (nonatomic, retain) NSArray *imageURLs;

- (void)fillProducts;

@end
