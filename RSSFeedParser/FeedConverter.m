
#import <UIKit/UIKit.h>
#import "FeedConverter.h"
#import "ImageResize.h"

static CGFloat const kSizeIncreaseMultiplier = 1.3;

@implementation FeedConverter: NSObject

#pragma mark - DataConverter methods

/**
 Filters data received from the service and transforms it to cell model
 */

- (FeedCellModel *) convertFeed:(FeedPlainObject *)feed {
	
	FeedCellModel* cellModel = [FeedCellModel new];
	
	cellModel.feedDescription = [NSString stringWithString:feed.feedDescription];
	cellModel.title = [NSString stringWithString:feed.title];
	cellModel.feedOrigin = [NSString stringWithString:feed.feedOrigin];
	cellModel.date = [self.dateReceiverFormatter dateFromString:feed.dateStringRepresentation];
	cellModel.dateString = [self.stringReceiverFormatter stringFromDate: cellModel.date];
	
	if (feed.imageData != nil) {
		cellModel.image = [self convertNSDataToImageDependingOnCellConfiguration:feed.imageData];
	}
	
	return cellModel;
}

/**
 Transforms NSData to UIImage and resizes it, so it would fit into cells and won't take 
 too much space in the memory
 */
- (UIImage *) convertNSDataToImageDependingOnCellConfiguration:(NSData *)data {
	
	CellConfiguration configuration = [self.delegate getCellConfiguration];
	
	// increasing size a little bit, so the image won't look blurry
	CGSize imageSize = configuration.imageSize;
	imageSize.height = imageSize.height * kSizeIncreaseMultiplier;
	imageSize.width = imageSize.width * kSizeIncreaseMultiplier;
	
	UIImage *image = [UIImage imageWithData:data];
	image = [image resizeScaleAspectFit:imageSize];
	
	return image;
}

@end
