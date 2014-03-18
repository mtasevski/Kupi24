//
//  ProductDetail.m
//  Kupi24
//
//  Created by Milena Tasev on 1/29/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ProductDetail.h"
#import "Product.h"

@implementation ProductDetail

@synthesize txtIme, txtPrezime, txtTelefon, txtAdresa, txtGrad, txtEmail, btnKupi, productID, scr, nameLabel, descriptionLabel, productImageView, btnChooseNumber, product, numbersPicker, numbersList, lblNewPrice, lblOldPrice, lblDostavaDoDoma, lblVkupno, lblSelectedNumber, lblFormaZaNaracka, btnVoRed, imgRectangle;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // [self setNeedsStatusBarAppearanceUpdate];
    
    
   /* UIImage *resultingImage;
    UIGraphicsBeginImageContext(CGSizeMake(42, 29));
	
	CGContextRef context = UIGraphicsGetCurrentContext();
    
	// drawing with a white stroke color
	CGContextSetRGBStrokeColor(context, 0.0, 1.0, 1.0, 1.0);
	// drawing with a white fill color
	CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
	// Add Filled Rectangle,
	CGContextFillRect(context, CGRectMake(0.0, 0.0, 40, 27));
    
	resultingImage = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
    
    [imgRectangle setImage:resultingImage];
    */
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setFrame:CGRectMake(230, 310, 50, 50)];
    [button1 addTarget:self action:@selector(onBtnIzberiBroj:) forControlEvents:UIControlEventTouchDown];
   // button1.layer.borderWidth = 0.5f;
    [scr addSubview:button1];
    
    //button.layer.cornerRadius = 5;
    
    
    lblSelectedNumber.hidden = YES;
    [numbersPicker setBackgroundColor:[UIColor whiteColor]];
    
    //self.automaticallyAdjustsScrollViewInsets = YES;
    
    NSLog(@"SELF VIEW FRAME = %f", self.view.frame.size.height);
    
    
    //[lblSelectedNumber setText:[numbersList objectAtIndex:0]];
    
    
   // pickerIsShown = 0;
    //[txtIme becomeFirstResponder];
    
    UIImage *buttonImage = [UIImage imageNamed:@"back-btn.png"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:buttonImage forState:UIControlStateNormal];
    
    
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = customBarItem;
   
    kOffsetForKeyboard = 150;
    
    [numbersPicker setDataSource: self];
    [numbersPicker setDelegate: self];
    
    numbersPicker.showsSelectionIndicator = YES;
    
    [scr setContentSize:CGSizeMake(0, 1100)];
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:product.imgProduct]];
    [productImageView setImage:[UIImage imageWithData:imageData]];
    
    [nameLabel setTextColor:[UIColor colorWithRed:1 green:23.5/100 blue:18.8/100 alpha:1]];
    [nameLabel setFont:[UIFont fontWithName:@"NeoSansProRegular" size:16]];
    nameLabel.text = product.title;
    
    [lblFormaZaNaracka setFont:[UIFont fontWithName:@"NeoSansProRegular" size:16]];
    lblFormaZaNaracka.text = @"Форма за нарачка:";
    
    [descriptionLabel setFont:[UIFont fontWithName:@"NeoSansProRegular" size:12]];
    descriptionLabel.text = product.description;
   
    [btnChooseNumber.titleLabel setFont:[UIFont fontWithName:@"NeoSansProRegular" size:12]];
    //[btnChooseNumber setTitleColor:[UIColor colorWithRed:1 green:23.5/100 blue:18.8/100 alpha:1] forState:UIControlStateNormal];
    [btnChooseNumber setTitle:@"избери број:" forState:UIControlStateNormal];
    
    [btnKupi.titleLabel setFont:[UIFont fontWithName:@"NeoSansProRegular" size:14]];
    [btnKupi setTitleColor:[UIColor colorWithRed:1 green:23.5/100 blue:18.8/100 alpha:1] forState:UIControlStateNormal];
    
    [btnVoRed.titleLabel setFont:[UIFont fontWithName:@"NeoSansProRegular" size:14]];
    [btnVoRed setTitleColor:[UIColor colorWithRed:1 green:23.5/100 blue:18.8/100 alpha:1] forState:UIControlStateNormal];
    [btnVoRed setTitle:@"Во ред" forState:UIControlStateNormal];
    btnVoRed.hidden = YES;
    
    [btnKupi setImage:[UIImage imageNamed:@"btn-buy2.png"] forState:UIControlStateNormal];
    [btnKupi setImage:[UIImage imageNamed:@"btn-buy-hover2.png"] forState:UIControlStateHighlighted];
    
    [lblOldPrice setTextColor:[UIColor grayColor]];
    [lblOldPrice setFont:[UIFont fontWithName:@"NeoSansProRegular" size:12]];
    [lblNewPrice setFont:[UIFont fontWithName:@"NeoSansProRegular" size:12]];
    [lblDostavaDoDoma setFont:[UIFont fontWithName:@"NeoSansProRegular" size:12]];
    [lblVkupno setFont:[UIFont fontWithName:@"NeoSansProRegular" size:12]];
    
    lblOldPrice.text = [NSString stringWithFormat:@"%@ ден.", product.oldPrice];
    lblNewPrice.text = [NSString stringWithFormat:@"%@ ден.", product.novaCena];
    lblDostavaDoDoma.text = @"достава до дома: 130ден.";
   
   // int novaCena = [[product.novaCena] intValue] + 130;
    lblVkupno.text = [NSString stringWithFormat:@"вкупно: %d ден.", [product.novaCena intValue] + 130 ];
    
    numbersList = [[NSMutableArray alloc] init];
    
    NSLog(@"PRODUCT = %@", product.arrNumbers);
    [numbersList addObjectsFromArray:product.arrNumbers];
    
    NSMutableArray *copy = [numbersList copy];
    NSInteger index = [copy count] - 1;
    for (id object in [copy reverseObjectEnumerator]) {
        if ([numbersList indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) {
            [numbersList removeObjectAtIndex:index];
        }
        index--;
    }
    
    NSArray *sortedArray = [numbersList sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    numbersList = (NSMutableArray *)sortedArray;
    
    NSLog(@"numbers list = %@", numbersList);
    
    numbersPicker.hidden = YES;
   // navBar.hidden = YES;
    
    
  /*  if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;*/
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

/*- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}*/

-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [numbersList count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    
    NSLog(@"afajkfnal = %@", [numbersList objectAtIndex:row]);
    
    NSString *title;
    title=[numbersList objectAtIndex:row];  
    return title; 
    
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   
    product.strChoosenNumber = [numbersList objectAtIndex:row];
    [lblSelectedNumber setText:product.strChoosenNumber];
    [self.view setNeedsDisplay];
    
   // numbersPicker.hidden = YES;
    

}

- (IBAction)onBtnIzberiBroj:(id)sender {
    
    if ([numbersList count] == 0)
        return;
    
    btnVoRed.hidden = NO;
    //if (!pickerIsShown) {
        pickerIsShown = 1;
       // [scr setContentOffset:CGPointMake(0, 0)];
        
        numbersPicker.hidden = NO;
      //  navBar.hidden = NO;
    
    if ([lblSelectedNumber.text length] == 0) {
        [lblSelectedNumber setText:[numbersList objectAtIndex:0]];
        product.strChoosenNumber = [numbersList objectAtIndex:0];
    }
    
    lblSelectedNumber.hidden = NO;
     //   [numbersPicker reloadAllComponents];
   /* } else  {
        
        pickerIsShown = 0;
        //[scr setContentOffset:CGPointMake(0, 150)];
        
        numbersPicker.hidden = YES;
      //  navBar.hidden = NO;
        
        [btnChooseNumber.titleLabel setText:@"Избери број"];
        [self.view setNeedsDisplay];
        [numbersPicker reloadAllComponents];
    }*/
    
    
}

- (IBAction)onBtnVoRed:(id)sender {
    
    numbersPicker.hidden = YES;
    btnVoRed.hidden = YES;
    
   // [lblSelectedNumber setText:product.strChoosenNumber];
    lblSelectedNumber.hidden = NO;
    
    
   
}

- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    
    return [emailTest evaluateWithObject:candidate];
}

- (IBAction)onBtnKupi:(id)sender {
    
  /*  if (lblSelectedNumber.hidden) {
        NSString *message = [NSString stringWithFormat:@"Ве молиме изберете број"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Известување" message:message delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        return;
    }
    
    if (([txtIme.text length] == 0) || ([txtPrezime.text length] == 0) || ([txtGrad.text length] == 0) || ([txtEmail.text length] == 0) || ([txtAdresa.text length] == 0) || ([txtTelefon.text length] == 0)) {
        
        NSString *textOdPraznoPole = [[NSString alloc] init];
        
        if ([txtGrad.text length] == 0) {
            textOdPraznoPole = @"град";
        }
        if ([txtEmail.text length] == 0) {
            textOdPraznoPole = @"e-mail";
        }
        if ([txtAdresa.text length] == 0) {
            textOdPraznoPole = @"адреса";
        }
        if ([txtTelefon.text length] == 0) {
            textOdPraznoPole = @"телефон";
        }
        if ([txtPrezime.text length] == 0) {
            textOdPraznoPole = @"презиме";
        }
        if ([txtIme.text length] == 0) {
            textOdPraznoPole = @"име";
        }
        
       
        
        
        
        NSString *message = [NSString stringWithFormat:@"Ве молиме внесете %@.", textOdPraznoPole];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Известување" message:message delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
        
        [alert show]; 
        
        return;
    }
    
    if (![self validateEmail:txtEmail.text]) {
        NSString *message = [NSString stringWithFormat:@"Ве молиме внесете точна е-mail адреса."];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Известување" message:message delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
        [alert show];
        return;
        
    }*/
    
    
   // NSString *strrr = [NSString stringWithFormat:"ТЕСТТЕТМАНОГЈБАОФ"];
    
    NSString *post = [NSString stringWithFormat:@"name=%@&surName=%@&email=%@&phone=%@&address=%@&city=%@&productId=%@&brojce=%@&ref=iphone", txtIme.text, txtPrezime.text, txtEmail.text, txtTelefon.text, txtAdresa.text, txtGrad.text, productID, product.strChoosenNumber];
    
    NSLog(@"POST = %@", post);
    
   //  NSString *post = @"name=Milena&surName=Tasevski&email=vknvkaa&phone=98341984&address=1414&city=aefa&productId=14&brojce=20&ref=iphone";
    
     NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];//NSASCIIStringEncoding
     
     NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
     
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
     [request setURL:[NSURL URLWithString:@"http://kupi24.mk/order.php"]];
     [request setHTTPMethod:@"POST"];
     [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
     [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
     [request setHTTPBody:postData];
     
     (void) [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
   
    
    /*UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    lbl.text = @"kupi24.mk";
    [lbl setTextColor:[UIColor colorWithRed:1 green:23.5/100 blue:18.8/100 alpha:1]];
    */
    UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle: @"Ви благодариме" message:@"Вашата нарачка е успешно направена. Во наредните 24 часа ќе бидете контактирани од нашиот оператор (078 295 715) за да ја потврдите Вашата нарачка. " delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
   // [alert1 addSubview:lbl];
    
    [alert1 show]; 
    
            [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	
    [responseData setLength:0];
    NSLog(@"responseeeeeeeeeeEEEEE = %@", response);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"Connection Failed!");    
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {	
	
   
    
}



-(void)keyboardWillShow {
    
    NSLog(@"KEyboard will show!");
    
    if (scr.contentOffset.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (scr.contentOffset.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    
    if (self.view.frame.origin.y >= 0)
    {
       // [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
       // [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    
    if ([sender isEqual:txtIme])
        kOffsetForKeyboard = 400;
    if ([sender isEqual:txtPrezime]) 
        kOffsetForKeyboard = 470;
    if ([sender isEqual:txtTelefon]) 
        kOffsetForKeyboard = 540;
    if ([sender isEqual:txtAdresa])
        kOffsetForKeyboard = 610;
    if ([sender isEqual:txtEmail]) 
        kOffsetForKeyboard = 660;
    if ([sender isEqual:txtGrad]) 
        kOffsetForKeyboard = 750;
}

-(void)setViewMovedUp:(BOOL)movedUp
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; 
    
    if (movedUp)
        [scr setContentOffset:CGPointMake(0, kOffsetForKeyboard)]; 
    else
        [scr setContentOffset:CGPointMake(0, kOffsetForKeyboard)]; 
    
    [UIView commitAnimations];
}

- (void)viewWillAppear:(BOOL)animated
{
  
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


@end
