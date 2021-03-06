
#import <Foundation/Foundation.h>

#import "MainFeedInteractor.h"

@implementation MainFeedInteractor: NSObject

#pragma mark - MainFeedInteractorOutput methods

- (void) startSearchingForRSSFeeds {
	[self.service findFeeds];
}

#pragma mark - RSSFeedParserServiceOutput methods

/**
 This method is called by the service upon download
 */

- (void) didDownloadFeed:(FeedPlainObject *)feed {
	
	if (feed != nil) {
		[self.presenter showFeed:feed];
		return;
	}
}

- (void) errorDidOccur:(NSError *)error {
	[self.presenter showError:error];
}

@end