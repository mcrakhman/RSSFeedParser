
#import "RSSFeedParserService.h"

@implementation GazetaLentaRSSFeedParserService

#pragma mark - RSSFeedParseService methods

- (void) findFeeds {
	
	[self.lentaParser parse];
	[self.gazetaParser parse];
}

#pragma mark - RSSFeedParser methods

/**
 The method attaches image data to the XML file
 */

- (void) didDownloadRSSFeedXMLData: (FeedPlainObject *)feed {
	NSString* url = feed.imageUrlString;
	
	if (url == nil) {
		[self.output didDownloadFeed:feed];
		return;
	}
	__weak typeof(self) welf = self;
	
	[self.downloader downloadDataForUrlString:url withBlock: ^(NSData* data, NSError* error) {
		
		if (data != nil) {
			feed.imageData = [NSData dataWithData:data];
			[welf.output didDownloadFeed:feed];
		} else {
			[welf errorDidOccur:error];
		}
	}];
}

- (void) errorDidOccur:(NSError *)error {
	[self.output errorDidOccur:error];
}

@end
