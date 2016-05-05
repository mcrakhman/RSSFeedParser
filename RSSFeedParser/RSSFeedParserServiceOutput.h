
#ifndef RSSFeedParserOutput_h
#define RSSFeedParserOutput_h

#import "FeedPlainObject.h"

@protocol RSSFeedParserServiceOutput <NSObject>

- (void) didDownloadFeed: (FeedPlainObject *) feed;
- (void) errorDidOccur: (NSError *) error;

@end

#endif /* RSSFeedParserOutput_h */
