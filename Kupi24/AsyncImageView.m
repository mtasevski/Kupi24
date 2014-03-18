

#import "AsyncImageView.h"
#import "ImageCacheObject.h"
#import "ImageCache.h"
#import "ViewController.h"
//#import "ViewOriginalNews.h"

//
// Key's are URL strings.
// Value's are ImageCacheObject's
//
static ImageCache *imageCache = nil;

@implementation AsyncImageView
@synthesize ref, delegate, view;

- (id)initWithFrame:(CGRect)frame {
    
   
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
    }
    return self;
}



- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self setContentMode:UIViewContentModeScaleToFill];
    
}

- (void)setRate:(BOOL)cond {

	if (cond) {
		if (btnDelete == nil) {
			
			if (zamagleno == nil) {
				
				zamagleno = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
				[zamagleno setBackgroundColor:[UIColor whiteColor]];
				[zamagleno setAlpha:0.7];
				[self addSubview:zamagleno];
                
               // [zamagleno release];
			}
			
			
			btnDelete = [[UIImageView alloc] init]; 
			btnDelete.frame = CGRectMake(self.bounds.size.width / 2.0f - 20, self.bounds.size.height / 2.0f - 20, 40, 40);
			btnDelete.userInteractionEnabled = NO;
			[btnDelete setImage:[UIImage imageNamed:@"delete.png"]];
			
			[self addSubview:btnDelete];
            
           // [btnDelete release];
		}
		//ratingdot.hidden = NO;
		
	}
	else {
		
		[zamagleno removeFromSuperview];
		zamagleno = nil;
		
		[btnDelete removeFromSuperview];
		btnDelete = nil;
	}
	
}



#pragma mark -

- (void)dealloc {
   // [connection cancel];
   // [connection release];
   // [data release];
   // [super dealloc];
}

-(void)loadImageFromURL:(NSURL*)url {
    if (connection != nil) {
        [connection cancel];
       // [connection release];
        connection = nil;
    }
    if (data != nil) {
        //[data release];
        data = nil;
    }
    
    if (imageCache == nil) // lazily create image cache
        imageCache = [[ImageCache alloc] initWithMaxSize:2*1024*1024];  // 2 MB Image cache
        
   // [urlString release];
    urlString = [[url absoluteString] copy];
    UIImage *cachedImage = [imageCache imageForKey:urlString];
    if (cachedImage != nil) {
        if ([[self subviews] count] > 0) {
            [[[self subviews] objectAtIndex:0] removeFromSuperview];
        }
        UIImageView *imageView = [[UIImageView alloc] initWithImage:cachedImage];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.autoresizingMask = 
            UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageView.tag = 5;
        [self addSubview:imageView];
        imageView.frame = self.bounds;
        [imageView setNeedsLayout]; // is this necessary if superview gets setNeedsLayout?
        [self setNeedsLayout];
        return;
    }    
#define SPINNY_TAG 5555                             
    
    UIActivityIndicatorView *spinny = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    spinny.tag = SPINNY_TAG;
    spinny.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [spinny startAnimating];
    [self addSubview:spinny];
  //  [spinny release];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection 
    didReceiveData:(NSData *)incrementalData {
    if (data==nil) {
        data = [[NSMutableData alloc] initWithCapacity:2048];
    }
    [data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection {
   // [connection release];
    connection = nil;
        
    UIView *spinny = [self viewWithTag:SPINNY_TAG];
    [spinny removeFromSuperview];
    
    if ([[self subviews] count] > 0) {
        [[[self subviews] objectAtIndex:0] removeFromSuperview];
    }
    
    UIImage *image = [UIImage imageWithData:data];
    
    [imageCache insertImage:image withSize:[data length] forKey:urlString];
    
    UIImageView *imageView = [[UIImageView alloc]
                               initWithImage:image];
    imageView.tag = 5;
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.autoresizingMask = 
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:imageView];
    imageView.frame = self.bounds;
    [imageView setNeedsLayout]; // is this necessary if superview gets setNeedsLayout?
    [self setNeedsLayout];
    //[data release];
    data = nil;
}

- (void)setStaticImage:(UIImage *)image {
    
    UIImageView *img = (UIImageView *)[self viewWithTag:5];
    [img setImage:image];  
    [self bringSubviewToFront:img];

    
}

- (UIImage *)getStaticImage {
    
    UIImageView *img = (UIImageView *)[self viewWithTag:5];
    return img.image;
}

-(void)deleteContent{
    UIImageView *img = (UIImageView *)[self viewWithTag:5];
    img.image = nil;
    [img removeFromSuperview];
    img = nil;
}

-(void)changeSpinnyPosition{
    
    UIActivityIndicatorView *spinny =(UIActivityIndicatorView *)[self viewWithTag:5555];

    spinny.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);

}

- (UIImage*)imageByScalingAndCroppingForSize1:(CGSize)targetSize :(UIImage *)img;
{
    
    UIImage *sourceImage = img;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = 0.0;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    //float imgPointX = (width - 592)/2;
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    //if(newImage == nil)
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
   // [[NSNotificationCenter defaultCenter] postNotificationName:@"showWebView" object:self];

  //  NSLog(@"%s .tag = %d, %d", __FUNCTION__, self.superview.tag, self.superview.superview.tag);
    
    
   // [view showWebView:self.superview.tag:self.superview.superview.tag];
    
    //NSLog(@"parentVIEW TAG = %@", self.superview.tag);
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    UITouch *touch = [touches anyObject];
    
    if ([touch tapCount] == 2) {
      //  drawImageView.image = nil;
        return;
    }
    
}

@end
