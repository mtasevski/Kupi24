//
//  AppDelegate.h
//  Kupi24
//
//  Created by Milena Tasev on 1/29/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, NSURLConnectionDelegate> {
    
    NSMutableArray *_products;
    
    NSMutableData *responseData;
    NSMutableData *pageData;
    NSArray *JSON;
    NSURLConnection *pageConnection;
    NSData *deviceToken;
}

@property (strong, nonatomic) UIWindow *window;

- (void)fillProducts;

@end
