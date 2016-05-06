
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ImageResize.h"

@implementation UIImage (Resize)

/**
 Resizes image so it will be of maximum size while fully fitting inside the "size" (parameter)
 */
- (UIImage *) resizeScaleAspectFit: (CGSize)size {
	
	CGFloat height = self.size.height;
	CGFloat width = self.size.width;

	CGFloat previousRatio = height / width;
	CGFloat newRatio = size.height / size.width;
	CGFloat percentageMultiplier = 0.0;
	
	if (previousRatio > newRatio) {
		percentageMultiplier = size.height / height;
	} else {
		percentageMultiplier = size.width / width;
	}
	
	[self drawWithWidth:width * percentageMultiplier andHeight:height * percentageMultiplier];

	UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return scaledImage;
	
}

- (void) drawWithWidth: (CGFloat)width andHeight: (CGFloat)height {
	
	UIGraphicsBeginImageContext (CGSizeMake(width, height));
	
	[self drawInRect:CGRectMake(0, 0, width, height)];
}


@end