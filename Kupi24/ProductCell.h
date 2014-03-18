//
//  ProductCell.h
//  Kupi24
//
//  Created by Milena Tasev on 1/30/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AsyncImageView;

@interface ProductCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UIImageView *productImageView;
@property (nonatomic, weak) IBOutlet UITextField *txtChooseNumber;
@property (nonatomic, weak) IBOutlet UILabel *lblOldPrice;
@property (nonatomic, weak) IBOutlet UILabel *lblNewPrice;

@end
