//
//  Product.h
//  Kupi24
//
//  Created by Milena Tasev on 1/30/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject 

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *imgProduct;
@property (nonatomic, copy) NSString *oldPrice;
@property (nonatomic, strong) NSString *novaCena;
@property (nonatomic, copy) NSArray *arrNumbers;
@property (nonatomic, copy) NSString *strChoosenNumber;

@end
