
#import <Foundation/Foundation.h>

#import "RSSFeedParserImplementation.h"

@implementation RSSFeedParserImplementation : NSObject

- (void) parse {
	
	[self configureFeedParser];
	__weak typeof(self) welf = self;
	
	// need to specify async parsing as NSXMLParser only works in sync
	dispatch_async(self.queue, ^{
		[welf beginParsing];
	});
}


#pragma mark - Private methods

- (void) beginParsing {
	if (![self.xmlParser parse]) {
		
		NSError* error = [NSError errorWithDomain:@"Ошибка при попытке чтения ленты" code:NSURLErrorUnknown userInfo:nil];
		
		[self.delegate errorDidOccur:error];
	}
}

- (void) configureFeedParser {
	
	NSURL *feedUrl = [NSURL URLWithString: _feedUrlString];
	
	if (![self checkFeedUrlAndReportErrorIfNeeded:feedUrl]) {
		return;
	}
	
	self.xmlParser = [[NSXMLParser alloc] initWithContentsOfURL: feedUrl];
	
	[self.xmlParser setDelegate: self];
	[self.xmlParser setShouldResolveExternalEntities: NO];
	
	self.queue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
}

- (BOOL) checkFeedUrlAndReportErrorIfNeeded: (NSURL *)feedUrl {
	
	if (feedUrl == nil) {
		
		NSError* error = [NSError errorWithDomain:@"Неправильный URL адрес RSS ленты" code:kCFErrorHTTPBadURL userInfo:nil];
		
		[self.delegate errorDidOccur:error];
		
		return false;
	}
	
	return true;
}

- (void) removeNewLineCharactersFromStrings {
	
	self.currentFeed.feedDescription = [[self.currentFeed.feedDescription stringByReplacingOccurrencesOfString:@"\n" withString:@""] mutableCopy];
	
	self.currentFeed.dateStringRepresentation = [[self.currentFeed.dateStringRepresentation stringByReplacingOccurrencesOfString:@"\n" withString:@""] mutableCopy];
	
	self.currentFeed.title = [[self.currentFeed.title stringByReplacingOccurrencesOfString:@"\n" withString:@""] mutableCopy];
}

#pragma mark - NSXMLParser methods

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
	
	self.elementName = elementName;
	
	if ([self.elementName isEqualToString:@"item"]) {
		
		self.currentFeed = [FeedPlainObject new];
		
		self.currentFeed.title = [NSMutableString new];
		self.currentFeed.feedDescription = [NSMutableString new];
		self.currentFeed.dateStringRepresentation = [NSMutableString new];
		self.currentFeed.feedOrigin = self.elementOrigin;
	}
	
	if ([self.elementName isEqualToString:@"enclosure"]) {
		self.currentFeed.imageUrlString = [attributeDict objectForKey:@"url"];
	}
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	
	if ([self.elementName isEqualToString:@"title"]) {
		[self.currentFeed.title appendString:string];
		
	}
	if ([self.elementName isEqualToString:@"description"]) {
		[self.currentFeed.feedDescription appendString:string];
		
	}
	if ([self.elementName isEqualToString:@"pubDate"]) {
		[self.currentFeed.dateStringRepresentation appendString:string];
	}
	
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	if ([elementName isEqualToString:@"item"]) {
		[self removeNewLineCharactersFromStrings];
		[self.delegate didDownloadRSSFeedXMLData:self.currentFeed];
	}
	
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	[self.delegate errorDidOccur:parseError];
}

@end