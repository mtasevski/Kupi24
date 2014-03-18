//
//  ProductDetail.h
//  Kupi24
//
//  Created by Milena Tasev on 1/29/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Product;

@interface ProductDetail : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate> {
    
    NSMutableData *responseData;
    
    IBOutlet UINavigationBar *navBar;
    int kOffsetForKeyboard, pickerIsShown;
   
}
    
@property (nonatomic, weak) IBOutlet UITextField *txtIme;
@property (nonatomic, weak) IBOutlet UITextField *txtPrezime;
@property (nonatomic, weak) IBOutlet UITextField *txtTelefon;
@property (nonatomic, weak) IBOutlet UITextField *txtAdresa;
@property (nonatomic, weak) IBOutlet UITextField *txtEmail;
@property (nonatomic, weak) IBOutlet UITextField *txtGrad;
@property (nonatomic, weak) IBOutlet UIButton *btnKupi;
@property (nonatomic, weak) IBOutlet UIScrollView *scr;

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UIImageView *productImageView;
@property (nonatomic, weak) IBOutlet UIButton *btnChooseNumber;

@property (nonatomic, weak) IBOutlet UILabel *lblOldPrice;
@property (nonatomic, weak) IBOutlet UILabel *lblNewPrice;

@property (nonatomic, retain) NSString *productID;
@property (nonatomic, retain) Product *product;

@property (strong, nonatomic) IBOutlet UIPickerView *numbersPicker;
@property (strong, nonatomic) NSMutableArray *numbersList;

@property (strong, nonatomic) IBOutlet UILabel *lblDostavaDoDoma;
@property (strong, nonatomic) IBOutlet UILabel *lblVkupno;
@property (strong, nonatomic) IBOutlet UILabel *lblSelectedNumber;
@property (strong, nonatomic) IBOutlet UILabel *lblFormaZaNaracka;
@property (strong,nonatomic) IBOutlet UIButton *btnVoRed;
@property (strong, nonatomic) IBOutlet UIImageView *imgRectangle;

- (IBAction)onBtnKupi:(id)sender;
- (IBAction)onBtnIzberiBroj:(id)sender;
- (IBAction)onBtnVoRed:(id)sender;

-(void)setViewMovedUp:(BOOL)movedUp;

@end
