
#ifndef RSSFeedParserImplementation_h
#define RSSFeedParserImplementation_h

#import "RSSFeedParser.h"

@interface RSSFeedParserImplementation : NSObject <RSSFeedParser>

@property (nonatomic, strong, readwrite) FeedPlainObject *currentFeed;
@property (nonatomic, strong, readwrite) NSString *elementName;
@property (nonatomic, strong, readwrite) NSString *elementOrigin;
@property (nonatomic, strong, readwrite) NSString *feedUrlString;
@property (nonatomic, strong, readwrite) NSXMLParser *xmlParser;
@property (nonatomic, weak, readwrite) id <RSSFeedParserDelegate> delegate;

@property (nonatomic, readwrite) dispatch_queue_t queue;

@end

#endif /* RSSFeedParserImplementation_h */
