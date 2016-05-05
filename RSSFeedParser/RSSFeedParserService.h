
#import <Foundation/Foundation.h>
#import "DataDownloader.h"
#import "RSSFeedParser.h"
#import "RSSFeedParserServiceOutput.h"

@protocol RSSFeedParserService <RSSFeedParserDelegate>

- (void) findFeeds;

@end

@interface GazetaLentaRSSFeedParserService : NSObject <RSSFeedParserService>

@property (nonatomic, strong, readwrite) id <RSSFeedParser> lentaParser;
@property (nonatomic, strong, readwrite) id <RSSFeedParser> gazetaParser;
@property (nonatomic, weak, readwrite) id <RSSFeedParserServiceOutput> output;
@property (nonatomic, strong, readwrite) id <DataDownloader> downloader;

@end