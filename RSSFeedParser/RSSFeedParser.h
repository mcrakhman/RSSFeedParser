
#ifndef RSSFeedParser_h
#define RSSFeedParser_h

#import <Foundation/Foundation.h>
#import "FeedPlainObject.h"


@protocol RSSFeedParserDelegate <NSObject>

/**
 Notify the delegate that the data was downloaded and provide the data
 */
- (void) didDownloadRSSFeedXMLData: (FeedPlainObject *)feed;
- (void) errorDidOccur: (NSError *)error;

@end


@protocol RSSFeedParser <NSObject, NSXMLParserDelegate>

@property (nonatomic, weak, readwrite) id <RSSFeedParserDelegate> delegate;

/**
 Start parsing feeds
 */
- (void) parse;

@end


#endif /* RSSFeedParser_h */
