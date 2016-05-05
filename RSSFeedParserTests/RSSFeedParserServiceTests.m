//
//  RSSFeedParserServiceTests.m
//  RSSFeedParser
//
//  Created by MIKHAIL RAKHMANOV on 05.05.16.
//  Copyright © 2016 No Logo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "FeedPlainObject.h"
#import "RSSFeedParserService.h"

@interface RSSFeedParserServiceTests : XCTestCase

@property (strong, nonatomic, readwrite) GazetaLentaRSSFeedParserService* service;
@property (strong, nonatomic, readwrite) id mockOutput;
@property (strong, nonatomic, readwrite) id mockDownloader;

@end

@implementation RSSFeedParserServiceTests

- (void)setUp {
    [super setUp];

	self.service = [GazetaLentaRSSFeedParserService new];
	self.mockOutput = OCMProtocolMock(@protocol(RSSFeedParserServiceOutput));
	self.mockDownloader = OCMProtocolMock(@protocol(DataDownloader));
	
	self.service.output = self.mockOutput;
	self.service.downloader = self.mockDownloader;
}

- (void)tearDown {
	
	self.mockOutput = nil;
	self.service = nil;
	
	[super tearDown];
}

- (void) testThatAfterXMLParseTheDownloadIsCalledIfUrlIsNotNil {
	
	// given
	
	FeedPlainObject* feed = [FeedPlainObject new];
	feed.imageUrlString = @"http://www.url.com/image.jpg";
	
	// when
	
	[self.service didDownloadRSSFeedXMLData:feed];
	
	// then
	
	OCMVerify([self.mockDownloader downloadDataForUrlString:feed.imageUrlString withBlock:OCMOCK_ANY]);
}

- (void) testThatAfterXMLParseTheOutputIsCalledIfUrlIsNil {
	
	// given
	
	FeedPlainObject* feed = [FeedPlainObject new];
	feed.imageUrlString = nil;
	
	// when
	
	[self.service didDownloadRSSFeedXMLData:feed];
	
	// then
	
	OCMVerify([self.mockOutput didDownloadFeed:feed]);
}

- (void) testThatErrorOccuredIsCalledOnTheOutputIfTheErrorOccured {
	
	// given
	
	NSError* error = [NSError new];
	
	// when
	
	[self.service errorDidOccur:error];
	
	//then
	
	OCMVerify([self.mockOutput errorDidOccur:error]);
}

@end
