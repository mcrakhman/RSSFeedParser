
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

- (void) sortFeeds {
	
	NSComparisonResult (^comparisonBlock) (FeedCellModel *obj1, FeedCellModel *obj2) = ^(FeedCellModel *obj1, FeedCellModel *obj2) {
		
		return [obj2.date compare:obj1.date];
	};
	
	[self.feeds sortUsingComparator:comparisonBlock];
}

#pragma mark - DataConverterStore methods

- (void) addFeed:(FeedPlainObject *)feed {

	__weak typeof(self) welf = self;
	
	dispatch_async(self.queue, ^{
		FeedCellModel* newFeed = [welf.converter convertFeed:feed];
		
		[welf.feeds addObject:newFeed];
		[welf sortFeeds];
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