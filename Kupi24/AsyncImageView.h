




#import <UIKit/UIKit.h>

@class ViewController;

@interface AsyncImageView : UIImageView {
    
	NSURLConnection *connection;
    NSMutableData *data;
    NSString *urlString; // key for image cache dictionary
	
	id ref, delegate;
	UIImageView *btnDelete;
	UIView *zamagleno;
    
    UIImageView *bgPlaceholder;
    
    ViewController *view;

}

@property (nonatomic, retain) id ref;
@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) ViewController *view;

-(void)loadImageFromURL:(NSURL*)url;

-(void)setRate:(BOOL)cond;

-(void)setStaticImage:(UIImage *)image;
-(UIImage *)getStaticImage;
-(void)deleteContent;
-(void)changeSpinnyPosition;

@end
