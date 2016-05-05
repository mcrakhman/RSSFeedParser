//
//  RSSFeedParserImplementationTests.m
//  RSSFeedParser
//
//  Created by MIKHAIL RAKHMANOV on 04.05.16.
//  Copyright © 2016 No Logo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "RSSFeedParserImplementation.h"

static NSString* const testXMLString = @"<item>\n<guid>Guid</guid>\n<title>Title</title>\n<link>Link</link>\n<description>\n<![CDATA[Description]]>\n</description>\n<pubDate>PubDate</pubDate>\n<enclosure url=\"EnclosureUrl\" length=\"0\" type=\"image/jpeg\"/>\n<category>Россия</category>\n</item>";

// Private methods used for testing

@interface RSSFeedParserImplementation (PrivateMethods)

- (void) beginParsing;

@end

@interface RSSFeedParserImplementationTests : XCTestCase

@property (nonatomic, strong, readwrite) RSSFeedParserImplementation *parser;
@property (nonatomic, strong, readwrite) id mockDelegate;

@end

@implementation RSSFeedParserImplementationTests

- (void)setUp {
    [super setUp];
	
	self.parser = [RSSFeedParserImplementation new];
	NSData* data = [testXMLString dataUsingEncoding:NSUTF8StringEncoding];
	
	self.parser.xmlParser = [[NSXMLParser alloc] initWithData:data];
	[self.parser.xmlParser setDelegate: self.parser];
	[self.parser.xmlParser setShouldResolveExternalEntities: NO];

	self.mockDelegate = OCMProtocolMock(@protocol(RSSFeedParserDelegate));
	
	self.parser.delegate = self.mockDelegate;
}

- (void)tearDown {
	self.parser = nil;
	
    [super tearDown];
}

- (void) testWhetherParserReadsXMLAsExpected {

	// given
	
	// then
	
	[[self.mockDelegate expect] didDownloadRSSFeedXMLData:[OCMArg checkWithBlock:^BOOL(id object) {
		
		FeedPlainObject* feed = (FeedPlainObject *) object;
		
		BOOL feedDescriptionCorrect = [feed.feedDescription isEqualToString:@"Description"];
		BOOL feedTitleCorrect = [feed.title isEqualToString:@"Title"];
		BOOL feedDateStringCorrect = [feed.dateStringRepresentation isEqualToString:@"PubDate"];
		BOOL feedUrlCorrect = [feed.imageUrlString isEqualToString:@"EnclosureUrl"];
		
		return feedDescriptionCorrect && feedTitleCorrect && feedDateStringCorrect && feedUrlCorrect;
	}]];
	
	// when
	
	[self.parser beginParsing];
	
	// then
	
	[self.mockDelegate verify];
}

@end
