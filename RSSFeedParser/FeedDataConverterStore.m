
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FeedDataConverterStore.h"
#import "InRssDateFormatter.h"
#import "ImageResize.h"
#import "OutRussianDateFormatter.h"
#import "FeedCellModel.h"

@implementation FeedDataConverterStore: NSObject

- (id) init {
	if (self = [super init]) {
		self.feeds = [NSMutableArray new];
		self.queue = dispatch_queue_create ("FeedConverterStoreQueue", NULL);
	}
	
	return self;
}

#pragma mark - Private methods

- (void) sortCellModels {
	
	NSComparisonResult (^comparisonBlock) (FeedCellModel *obj1, FeedCellModel *obj2) = ^(FeedCellModel *obj1, FeedCellModel *obj2) {
		
		return [obj2.date compare:obj1.date];
	};
	
	[self.feeds sortUsingComparator:comparisonBlock];
}

- (void) convertFeedAndAddAsACellModel: (FeedPlainObject *) feed {
	
	FeedCellModel* newFeed = [self.converter convertFeed:feed];
	[self.feeds addObject:newFeed];
}

- (void) sortUpdateArrayWithNewFeed: (FeedPlainObject *) feed {
	
	[self convertFeedAndAddAsACellModel:feed];
	[self sortCellModels];
}

#pragma mark - DataConverterStore methods


/** 
 Adding feeds so that any modifications to the array is made on the serial queue to avoid race conditions
 */
- (void) addFeed:(FeedPlainObject *)feed {

	__weak typeof(self) welf = self;
	
	dispatch_async(self.queue, ^{
		[welf sortUpdateArrayWithNewFeed:feed];
	});
	
}

- (FeedCellModel *) feedAtIndex:(NSUInteger)index {
	if (self.feeds.count > index) {
		return self.feeds [index];
	}
	
	return nil;
}

- (NSUInteger) totalFeeds {
	return self.feeds.count;
}

@end